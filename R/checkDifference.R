#' @name sk_esd
#' @title A function to check the magnitude of the difference for all pairs of treatments
#'
#' @description  A function to check the magnitude of the difference for all pairs of treatments
#'
#' @author Chakkrit Tantithamthavorn (kla@chakkrit.com)
#' 
#' @param ranking A ranking that is produced by the Scott-Knott ESD test
#' @param data a data frame of treatment means
#' 
#' @return A result of the magnitude of the difference for all pairs of treatments.
#' 
#' @examples
#' sk <- sk_esd(example)
#' checkDifference(sk$groups, example)
#' 
#' @export 
checkDifference <- function(ranking, data){
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


