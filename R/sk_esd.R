#' @name "sk_esd"
#' @title The Scott-Knott Effect Size Difference (ESD) Test
#'
#' @description  An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
#'
#' @author Chakkrit Tantithamthavorn (kla@chakkrit.com)
#' 
#' @param x A wide-format data frame.
#' @param alpha The significance level.
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
#' # For a long-format data frame
#' long <- melt(example, id.vars=0)
#' data <- long2wide(long)
#' sk <- sk_esd(data) 
#' 
#' @import ScottKnott 
#' @import reshape2 
#' @import effsize 
#' @import stats 
#' @rdname sk_esd
#' @aliases SK.ESD
#' @export 
"sk_esd" <- function(x, alpha=0.05, ...){
    
    x <- data.frame(x)
    
    # apply ANOVA and Scott-Knott test
    av <- stats::aov(value ~ variable, data=reshape2::melt(x, id.vars=0 )) 
    sk <- ScottKnott::SK(av, which='variable',  dispersion='s', sig.level=alpha) 
    sk$original <- sk$groups; names(sk$original) <- rownames(sk$m.inf)
    ranking <- sk$groups; names(ranking) <- rownames(sk$m.inf)
    sk$diagnosis <- NULL
    keys <- names(ranking)    
    
    # join groups with negligible effect sizes
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