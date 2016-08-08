#' @export
"SKESD.default" <- function(data, long=FALSE, ...){
    library(ScottKnott); library(reshape2); library(effsize); library(stats)
    if(long){
        tmp <- do.call(cbind, split(data, data$variable))  
        tmp <- tmp[,grep("value",names(tmp))]
        names(tmp) <- gsub(".value", "", names(tmp))
        data <- tmp
    }
    data <- as.data.frame(data)
    
    transformLog  <- function(y){ y <- log1p(y)}
    data <- as.data.frame(apply(data, 2, transformLog))
    
    av <- stats::aov(value ~ variable, data=reshape2::melt(data)) 
    sk <- ScottKnott::SK(av, which='variable',  dispersion='s', sig.level=0.05) 
    sk$original <- sk$groups; names(sk$original) <- rownames(sk$m.inf)
    ranking <- sk$groups; names(ranking) <- rownames(sk$m.inf)
    sk$diagnosis <- NULL
    keys <- names(ranking)    
    for(k in seq(2,length(keys)) ){
        eff <- unlist(effsize::cohen.d(data[,keys[k]], data[,keys[k-1]])[c("magnitude","estimate")])
        sk$diagnosis <- rbind(sk$diagnosis,c(sprintf("[%d] %s (%.3f)",ranking[k-1],keys[k-1], mean(data[,keys[k-1]])),sprintf("[%d] %s (%.3f)",ranking[k],keys[k], mean(data[,keys[k]])),eff)) 
        if(eff["magnitude"] == "negligible" && ranking[k] != ranking[k-1]){ranking[seq(k,length(keys))] = ranking[seq(k,length(keys))] - 1;}
    }
    sk$groups <- ranking
    sk$reverse <- max(ranking)-ranking+1
    sk$diagnosis <- data.frame(sk$diagnosis)
    class(sk) <- c(class(sk),"SKESD")
    return(sk)
}

#' @export
print.SKESD <- function(object, ...){
    cat("\nGroups:\n")
    print(object$groups)
}
