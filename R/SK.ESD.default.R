#' @method SK.ESD default 
#' @importFrom ScottKnott SK 
#' @importFrom reshape2 melt 
#' @importFrom effsize cohen.d 
#' @importFrom stats aov 
#' @export
SK.ESD.default <- function(x, long=FALSE, ...){
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
    class(sk) <- c(class(sk),"SK.ESD")
    return(sk)
}

#' Print SK.ESD objects
#'
#' S3 method to print SK.ESD objects.
#'
#' @param x A SK.ESD object
#' @param ... Optional parameters.
#' 
#' @return The SK.ESD ranks
#' 
#' @rdname print
#' @method print SK.ESD
#' @export
print.SK.ESD <- function(x, ...){
    cat("\nGroups:\n")
    print(x$groups)
}
