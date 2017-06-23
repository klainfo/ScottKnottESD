##
## S3 method to 'aovlist' object
##

SK.aovlist <- function(x,
                       which,
                       id.trim=3,
                       error,
                       sig.level=.05,
                       dispersion=c('mm', 's', 'se'), ...)
{
  mt <- model.tables(x,
                     "means")  # summary tables for model fits

  if(is.null(mt$n))
    stop("No factors in the fitted model!")

  r   <- mt$n[names(mt$tables)][[which]] # groups and its number of replicates

  MSE <- deviance(x[[error]]) / df.residual(x[[error]])

  m   <- as.vector(mt$tables[[which]])  

  nms <- names(mt$tables[[which]])

  ord <- order(m,
                 decreasing=TRUE)

  m.inf <- m.inf.1b(x,
                    which,
                    dispersion)

  rownames(m.inf) <- nms

  m.inf <- m.inf[order(m.inf[,1],
                       decreasing=TRUE),]

  mMSE <- MSE / r

  dfr  <- df.residual(x[[error]])

  g    <- nrow(m.inf)

  groups <- MaxValue(g,
                     m.inf[, 1],
                     mMSE,
                     dfr,
                     sig.level=sig.level,
                     1,
                     rep(0, g),
                     0,
                     rep(0, g))
  
  res <- list(av=x,
              groups=groups,
              nms=nms,
              ord=ord,
              m.inf=m.inf,
              sig.level=sig.level,
              tab=mt$tables[[which]])

  class(res) <- c('SK',
                  'list')
  
  invisible(res)
}
