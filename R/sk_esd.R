#' @name sk_esd
#' @title The Scott-Knott Effect Size Difference (ESD) Test
#'
#' @description  An enhancement of the Scott-Knott test (which cluster distributions into statistically distinct ranks) that takes effect size into consideration.
#' 
#' @param x A wide-format data frame.
#' @param alpha The significance level.
#' @param ... Optional parameters.
#' 
#' @return A sk_esd object.
#' 
#' @examples
#' sk <- sk_esd(example)
#' plot(sk)
#' 
#' sk <- sk_esd(maven)
#' plot(sk)
#' 
#' @import reshape2 
#' @rdname sk_esd
#' @aliases SK.ESD
#' @export 
sk_esd <- function(x, alpha=0.05, ...){
    x <- data.frame(x)
    av <- aov(value ~ variable, data=reshape2::melt(x, id.vars=0 )) 
    sk <- scottknott(av, which='variable',  dispersion='s', sig.level=alpha) 
    names(sk$groups) <- rownames(sk$m.inf)
    class(sk) <- c(class(sk),"sk_esd")
    return(sk)
}