m.inf.1a <- function(x,
                     which,
                     dispersion=c('mm', 's', 'se'))
{
  switch(match.arg(dispersion),
         mm = {
           m.inf <- aggregate(x$model[,1],
                              by=list(x$model[[which]]),
                              function(x) c(mean=mean(x),
                                            min=min(x),
                                            max=max(x)))[,2]
         }, s = {
           m.inf <- aggregate(x$model[,1],
                              by=list(x$model[[which]]),
                              function(x) c(mean=mean(x),
                                            'm - s'=mean(x) - sd(x),
                                            'm + s'=mean(x) + sd(x)))[,2]
         }, se= {
           m.inf <- aggregate(x$model[,1],
                              by=list(x$model[[which]]),
                              function(x) c(mean=mean(x),
                                            'm - se'=mean(x) - (sd(x) / sqrt(length(x))),
                                            'm + se'=mean(x) + (sd(x) / sqrt(length(x)))))[,2]
         })
}
