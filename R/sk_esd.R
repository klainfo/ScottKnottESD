#' @name "sk_esd"
#' @title The Scott-Knott Effect Size Difference (ESD) Test
#'
#' @description  An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
#'
#' @author Chakkrit Tantithamthavorn (kla@chakkrit.com)
#' 
#' @param x A wide-format data frame.
#' @param alpha The significance level.
#' @param ... Optional parameters.
#' 
#' @return A sk_esd object.
#' 
#' @examples
#' sk <- sk_esd(example)
#' sk$original  # Original Groups
#' sk$groups    # Corrected Groups with effect size wise
#' sk$reverse   # Reversed Groups
#' 
#' # For a long-format data frame
#' long <- melt(example, id.vars=0)
#' data <- long2wide(long)
#' sk <- sk_esd(data) 
#' 
#' @import reshape2 
#' @import effsize 
#' @import stats 
#' @rdname sk_esd
#' @aliases SK.ESD
#' @export 
sk_esd <- function(x, alpha=0.05, ...){
    x <- data.frame(x)
    av <- aov(value ~ variable, data=reshape2::melt(x, id.vars=0 )) 
    sk <- SK(av, which='variable',  dispersion='s', sig.level=alpha) 
    names(sk$groups) <- rownames(sk$m.inf)
    class(sk) <- c(class(sk),"sk_esd")
    return(sk)
}