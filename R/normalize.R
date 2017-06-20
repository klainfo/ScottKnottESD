#' @name "normalize"
#' @title Normalize non-normal distributions using the Box-Cox Power Transformation
#'
#' @description  Normalize non-normal distributions using the Box-Cox Power Transformation
#'
#' @author Chakkrit Tantithamthavorn (kla@chakkrit.com)
#' 
#' @param x A wide-format data frame.
#' @param ... Optional parameters.
#' 
#' @return A wide-format data frame.
#' 
#' @examples
#' normalized.data <- normalize(example)
#' 
#' @import car
#' @import forecast
#' @rdname normalize
#' @export 
normalize <- function(x, ...){
    x <- data.frame(x)        
    x <- apply(x, 2, function(y) forecast::BoxCox(y,forecast::BoxCox.lambda(y)))
    return(data.frame(x))
}