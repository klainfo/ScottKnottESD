#' The Scott-Knott Effect Size Difference (ESD) test
#'
#' An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
#'
#' @param data a long-format data frame
#' @export
#' @return a SK object
#' 
#' @examples
#' example
#' sk <- SK.ESD(example)
#' sk$original  # Original Groups
#' sk$groups    # Corrected Groups with effect size wise
#' sk$reverse   # Reversed Groups
#' 
#' sk <- SK.ESD(melt(example), long=TRUE)
#' 

# "SK.ESD" <-
#     function(x, ...){
#         UseMethod("SK.ESD")
#     }

SK.ESD.default <- function(x, long=FALSE, ...){
    library(ScottKnott); library(reshape2); library(effsize)
    if(long){
        tmp <- do.call(cbind, split(x, x$variable))  
        tmp <- tmp[,grep("value",names(tmp))]
        names(tmp) <- gsub(".value", "", names(tmp))
        x <- tmp
    }
    x <- data.frame(x)
    
    transformLog  <- function(y){ y <- log1p(y)}
    x <- apply(x, 2, transformLog)
    
    av <- aov(value ~ variable, x=melt(x)) 
    sk <- SK(av, which='variable',  dispersion='s', sig.level=0.05) 
    sk$original <- sk$groups; names(sk$original) <- rownames(sk$m.inf)
    ranking <- sk$groups; names(ranking) <- rownames(sk$m.inf)
    sk$diagnosis <- NULL
    keys <- names(ranking)    
    for(k in seq(2,length(keys)) ){
        eff <- unlist(cohen.d(x[,keys[k]], x[,keys[k-1]])[c("magnitude","estimate")])
        sk$diagnosis <- rbind(sk$diagnosis,c(sprintf("[%d] %s (%.3f)",ranking[k-1],keys[k-1], mean(x[,keys[k-1]])),sprintf("[%d] %s (%.3f)",ranking[k],keys[k], mean(x[,keys[k]])),eff)) 
        if(eff["magnitude"] == "negligible" && ranking[k] != ranking[k-1]){ranking[seq(k,length(keys))] = ranking[seq(k,length(keys))] - 1;}
    }
    sk$groups <- ranking
    sk$reverse <- max(ranking)-ranking+1
    sk$diagnosis <- x.frame(sk$diagnosis)
    class(sk) <- c(class(sk),"SK.ESD")
    return(sk)
}

print.SK.ESD <- function(object, ...){
    cat("\nGroups:\n")
    print(object$groups)
}
