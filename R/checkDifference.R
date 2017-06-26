#' @export 
checkDifference <- function(ranking, data){
    library(effsize)
    eff <- data.frame()
    for(i in 1:(ncol(data)-1)){
        for(j in (i+1):ncol(data)){
            eff <- rbind(eff, data.frame(
                i=as.character(colnames(data)[i]), 
                j=as.character(colnames(data)[j]),
                ranki=as.numeric(ranking[colnames(data)[i]]),
                rankj=as.numeric(ranking[colnames(data)[j]]),
                mag=as.character(cohen.d(data[,i], data[,j])$magnitude),
                est=abs(round(cohen.d(data[,i], data[,j])$estimate,digits = 3))
            )
            )
        }
    }
    rownames(eff) <- NULL
    
    a <- eff[eff$ranki == eff$rankj & eff$mag != "negligible",] # Within-group pairs with neg. diff
    b <- eff[eff$ranki != eff$rankj & eff$mag == "negligible",]  #Inter-group pairs with neg. diff
    # if(a != TRUE)
    
    return(eff)
}


