#' @name "sk_esd"
#' @title The Scott-Knott Effect Size Difference (ESD) Test
#'
#' @description  An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
#'
#' @author Chakkrit Tantithamthavorn (kla@chakkrit.com)
#' 
#' @param x A wide-format data frame.
#' @param long TRUE if the input data is a long-format.
#' @param ... Optional parameters.
#' 
#' @return A sk_esd object.
#' 
#' @examples
#' sk <- sk_esd(example)
#' sk$original  # Original Groups
#' sk$groups    # Corrected Groups with effect size wise
#' sk$reverse   # Reversed Groups
#' 
#' sk <- sk_esd(melt(example), long=TRUE) # Example command for a long format
#' 
#' @import ScottKnott 
#' @import reshape2 
#' @import effsize 
#' @import stats 
#' @rdname sk_esd
#' @aliases SK.ESD
#' @export 
"sk_esd" <- function(x, long=FALSE, ...){
    if(long){
        tmp <- do.call(cbind, split(x, x$variable))  
        tmp <- tmp[,grep("value",names(tmp))]
        names(tmp) <- gsub(".value", "", names(tmp))
        x <- tmp
    }
    x <- data.frame(x)
    
    transformLog  <- function(y){ y <- log1p(y)}
    x <- data.frame(apply(x, 2, transformLog))
    
    av <- stats::aov(value ~ variable, data=reshape2::melt(x)) 
    sk <- ScottKnott::SK(av, which='variable',  dispersion='s', sig.level=0.05) 
    sk$original <- sk$groups; names(sk$original) <- rownames(sk$m.inf)
    ranking <- sk$groups; names(ranking) <- rownames(sk$m.inf)
    sk$diagnosis <- NULL
    keys <- names(ranking)    
    for(k in seq(2,length(keys)) ){
        eff <- unlist(effsize::cohen.d(x[,keys[k]], x[,keys[k-1]])[c("magnitude","estimate")])
        sk$diagnosis <- rbind(sk$diagnosis,c(sprintf("[%d] %s (%.3f)",ranking[k-1],keys[k-1], mean(x[,keys[k-1]])),sprintf("[%d] %s (%.3f)",ranking[k],keys[k], mean(x[,keys[k]])),eff)) 
        if(eff["magnitude"] == "negligible" && ranking[k] != ranking[k-1]){ranking[seq(k,length(keys))] = ranking[seq(k,length(keys))] - 1;}
    }
    sk$groups <- ranking
    sk$reverse <- max(ranking)-ranking+1
    sk$diagnosis <- data.frame(sk$diagnosis)
    class(sk) <- c(class(sk),"sk_esd")
    return(sk)
}