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
SK.ESD <- 
    function(x, ...){
        UseMethod("SKESD")
    }
