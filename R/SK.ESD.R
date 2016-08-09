#' The Scott-Knott Effect Size Difference (ESD) Test
#'
#' An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
#'
#' @param x A wide-format data frame.
#' @param long TRUE if the input data is a long-format.
#' @param ... Optional parameters.
#' @return A SK.ESD object.
#' 
#' @examples
#' sk <- SK.ESD(example)
#' sk$original  # Original Groups
#' sk$groups    # Corrected Groups with effect size wise
#' sk$reverse   # Reversed Groups
#' 
#' sk <- SK.ESD(melt(example), long=TRUE)
#' 
#' @export
SK.ESD <- 
    function(x, ...){
        UseMethod("SK.ESD")
    }
