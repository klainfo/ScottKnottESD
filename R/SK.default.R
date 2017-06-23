##
## S3 method to design matrix and response variable or data.frame objects
##

SK.default <- function(x,
                       y=NULL,
                       model,
                       which, 
                       id.trim=3,
                       error,
                       sig.level=.05,
                       dispersion=c('mm', 's', 'se'), ...)   
{
  if (is.data.frame(y)) 
    y <- as.matrix(y[, 1])  # manova is not contemplated
  else
    stopifnot(is.atomic(y))

  if (is.matrix(x) || is.atomic(x))
    x <- as.data.frame(x)

  if(!is.null(y))
    dat <- as.data.frame(cbind(x,
                               y))
  else
    dat <- x

  av <- eval(substitute(aov(fo,
                            dat),
                        list(fo=formula(model))))

  if(class(av)[1] == 'aov')
    res <- SK.aov(x=av,
                  which=which,
                  id.trim=id.trim, 
                  sig.level=sig.level,
                  dispersion=dispersion)
  else
    res <- SK.aovlist(x=av,
                      which=which,
                      id.trim=id.trim, 
                      error=error,
                      sig.level=sig.level,
                      dispersion=dispersion)

  invisible(res)
}
