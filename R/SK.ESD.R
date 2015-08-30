#' The Scott-Knott Effect Size Difference (ESD) test
#'
#' An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
#'
#' @param data a long-format data frame
#' @export
#' @return a SK object
#' 
#' @examples
#' sk <- SK.ESD(example)
#' sk$original  # Original Groups
#' sk$groups    # Corrected Groups with effect size wise
#' sk$reverse   # Reversed Groups
#' 
#' sk <- SK.ESD(melt(example), long=TRUE)
#' 
SK.ESD <- function(data, long=FALSE){
    library(ScottKnott); library(reshape); library(effsize)
    if(long){
        tmp <- do.call(cbind, split(data, data$variable))  
        tmp <- tmp[,grep("value",names(tmp))]
        names(tmp) <- gsub(".value", "", names(tmp))
        data <- tmp
    }
    data <- data.frame(data)
    av <- aov(value ~ variable, data=melt(data)) 
    sk <- SK(av, which='variable',  dispersion='s', sig.level=0.05) 
    sk$original <- sk$groups; names(sk$original) <- rownames(sk$m.inf)
    ranking <- sk$groups; names(ranking) <- rownames(sk$m.inf)
    sk$diagnosis <- NULL
    keys <- names(ranking)    
    for(k in seq(2,length(keys)) ){
        eff <- unlist(cohen.d(data[,keys[k]], data[,keys[k-1]])[c("magnitude","estimate")])
        sk$diagnosis <- rbind(sk$diagnosis,c(sprintf("[%d] %s (%.3f)",ranking[k-1],keys[k-1], mean(data[,keys[k-1]])),sprintf("[%d] %s (%.3f)",ranking[k],keys[k], mean(data[,keys[k]])),eff)) 
        if(eff["magnitude"] == "negligible" && ranking[k] != ranking[k-1]){ranking[seq(k,length(keys))] = ranking[seq(k,length(keys))] - 1;}
    }
    sk$groups <- ranking
    sk$reverse <- max(ranking)-ranking+1
    sk$diagnosis <- data.frame(sk$diagnosis)
    return(sk)
}