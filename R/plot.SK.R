##
## S3 method to plot 'SK' object
##

plot.SK <- function(x,
                    pch=19,
                    col=NULL,
                    xlab=NULL,
                    ylab=NULL,
                    xlim=NULL,
                    ylim=NULL,
                    id.lab=NULL,
                    id.las=1,
                    id.col=TRUE,
                    rl=TRUE,
                    rl.lty=3,
                    rl.col='gray',
                    mm=TRUE,
                    mm.lty=1, 
                    title="Means grouped by color(s)", ...)
{
  if(!inherits(x, 'SK'))
    stop("Use only with 'SK' objects!")

  if(!is.null(col))  
    if(length(col) < max(x$groups)) 
      stop('Parameter "col", the number of colors is not enough, it must match 
           the number of groups!')

  if(is.null(xlab)) xlab <- 'Groups'

  if(is.null(ylab)) ylab <- 'Means'

  means  <- x$m.inf[, 1]

  groups <- 1:length(means) 

  minmax <- x$m.inf[, 2:3]

  if(is.null(col))
    col <- x$groups
  else {
    col <- col[1:max(x$groups)]
    col <- col[x$groups]
  }

  if(id.col)
    id.col <- col
  else 
    id.col <- NA

  if(is.null(xlim))
    xlim <- c(1, max(groups))

  if(is.null(ylim))
    ylim <- c(min(minmax[, 1]),
              max(minmax[, 2]))

  plot(groups,
       means,
       pch=pch,
       col=col,
       xlab=xlab,
       ylab=ylab,
       xlim=xlim,
       ylim=ylim,
       axes=FALSE, ...)

  if(rl == TRUE)       
    segments(rep(-0.5,
                 length(means)),
             means,
             groups,
             means,
             lty=rl.lty,
             col=rl.col, ...) 

  if(mm == TRUE)
    segments(groups,
             minmax[, 2],
             groups,
             minmax[, 1],
             lty=mm.lty,
             col=col, ...)

  axis(2,
       at=round(seq(ylim[1],
                    ylim[2],
                    length.out=5),
                1))

  if(is.null(id.lab))
    id.lab <- rownames(x$m.inf)

  axis(1,
       at=1:length(means),
       labels=id.lab,
       las=id.las,
       col.axis=FALSE, ...)    

  mtext(text=id.lab,
        side=1,
        line=1,
        at=1:length(means),
        col=id.col,
        las=id.las, ...)

  title(title, ...)
}

