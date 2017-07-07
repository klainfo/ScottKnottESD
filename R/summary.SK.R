##
## S3 method to sumarize 'SK' object
##

summary.SK <- function(object, ...)
{
  if(!inherits(object,
               'SK'))
    stop("Use only with \"SK\" objects!")

  ngroups <- object$groups[length(object$groups)]

  if(ngroups > 26)
    groupletter <- as.vector(t(outer(letters,
                                     letters,
                                     paste,
                                     sep="")))
  else
    groupletter <- letters

  xgroups <- seq(ngroups)

  for (i in 1:ngroups)
    object$groups[object$groups == xgroups[i]] <- groupletter[i]

  out <- data.frame(rownames(object$m.inf),
                    object$m.inf[, 1],
                    object$groups)

  names(out) <- c('Levels',
                  'Means',
                  paste('SK(',
                        100*object$sig.level,
                        '%)', 
                        sep=''))

  print(out,
        row.names=FALSE)
}
