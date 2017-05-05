#' @name "long2wide"
#' @title Convert data from long format to wide format
#'
#' @description  Convert data from long format to wide format
#'
#' @author Chakkrit Tantithamthavorn (kla@chakkrit.com)
#' 
#' @param x A long-format data frame.
#' @param ... Optional parameters.
#' 
#' @return A wide-format data frame.
#' 
#' @examples
#' long2wide(melt(example, id.vars=0))
#' 
#' @rdname long2wide
#' @export 
"long2wide" <- function(x, ...){

    # Convert data from long format to wide format
    tmp <- do.call(cbind, split(x, x$variable))  
    tmp <- tmp[,grep("value",names(tmp))]
    names(tmp) <- gsub(".value", "", names(tmp))
    x <- tmp
    return(x)
}