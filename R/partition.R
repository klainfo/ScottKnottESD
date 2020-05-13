# This is a modified version of https://github.com/jcfaria/ScottKnott/blob/master/R/MaxValue.R which is originally written by Jose Claudio Faria
# Change Notes:
# - Add an 'av' argument into the Partition() function
# - Remove the calculation of a lamdaa and a Chi-square distribution
# - Use Cohen d to check the effect size difference with the diff() function

#' @import effsize 
PartitionParametric <- function(g,
                     means,
                     mMSE,
                     dfr,
                     sig.level,
                     av,
                     k,
                     group,
                     ngroup,
                     markg,
                     g1=g,
                     sqsum=rep(0, g1))
{
    for(k1 in k:(g-1)) {
        t1 <- sum(means[k:k1])
        
        k2 <- g-k1
        
        t2 <- sum(means[(k1+1):g])
        
        # SK between groups sum of squares
        sqsum[k1] <- t1^2/(k1-k+1) + t2^2/k2 - (t1+t2)^2/(g-k+1)
    }
    
    # the first element of this vector is the value of k1 which maximizes sqsum (SKBSQS)
    ord1 <- order(sqsum, decreasing=TRUE)[1]
    
    ############################################################
    # Compute the magnitude of the difference of all treatments in a group
    # Use effect size test to identify whether to split metrics into two groups of {k:i} and {j:g}.
    # The split is accepted if effect.size({k}, {g}) != negligible
    diff <- function(k, g, av, means) {
        if(k==g){ # if k and g are the same treatment
            return(TRUE)
        }
        
        a <- av$model[av$model[,2] == names(means[k]),1]
        b <- av$model[av$model[,2] == names(means[g]),1]  

        if (all(a==b)) {
            return(TRUE)
        }
        
        magnitude <- as.character(cohen.d(a,b)$magnitude, paired=TRUE)
        return(magnitude == "negligible")
    }
    ############################################################
    
    # if true it returns one node to the right if false it goes forward one node to the left
    if(diff(k, g, av, means) | 
       (ord1 == k)) {
        # In the case of a single average left (maximum)
        if(!diff(k, g, av, means)) {
            # it marks the group to the left consisting of a single mean
            ngroup <- ngroup + 1
            
            # it forms a group of just one mean (the maximum of the group)
            group[k] <- ngroup
            
            # lower limit on returning to the right
            k <- ord1 + 1
        }
        if(diff(k, g, av, means)) {
            # it marks the groups
            ngroup <- ngroup + 1
            
            # it forms a group of means
            group[k:g] <- ngroup
            
            # if this group is the last one
            if (prod(group) > 0)
                # If the upper limit of the latter group formed is equal to the total
                # number of treatments than  the grouping algorithm is ended
                return (group)
            
            # it marks the lower limit of the group of means to be used in the
            # calculation of the maximum sqsum on returning one node to the right
            k <- g + 1
            
            # it marks the upper limit of the group of means to be used in the
            # calculation of the maximum sqsum on returning one node to the right
            g <- markg[g]
        }
        while(k == g) {
            # there was just one mean left to the right, so it becomes a group
            ngroup   <- ngroup + 1
            
            group[g] <- ngroup
            
            if(prod(group) > 0)
                # If the upper limit of the latter group formed is equal to the total
                # number of treatments than  the grouping algorithm is ended
                return(group)
            
            # the group of just one mean group had already been formed, a further
            # jump to the right and another check whether there was just one mean
            # left to the right
            k <- g + 1
            
            g <- markg[g]
        }
    } else {
        # it marks the upper limit of the group split into two to be used on
        # returning to the right later
        markg[ord1] <- g
        
        g <- ord1
    }
    
    PartitionParametric(g,
             means,
             mMSE,
             dfr,
             sig.level,
             av,
             k,
             group,
             ngroup,
             markg)
}

PartitionNonParametric <- function(g,
                     means,
                     mMSE,
                     dfr,
                     sig.level,
                     av,
                     k,
                     group,
                     ngroup,
                     markg,
                     g1=g,
                     sqsum=rep(0, g1))
{
    # Sort distributions by median values
    means <- rev(sort(apply(long2wide(av$model),2 , median)))
    
    for(k1 in k:(g-1)) {
        # Compute Sum of square based on the Chisq of Kruskal Wallis Rank Sum 
        sample <- av$model
        sample$variable <- as.character(sample$variable)
        sample[sample$variable %in% names(means[k:k1]),]$variable <- "left"
        sample[sample$variable %in% names(means[(k1+1):g]),]$variable <- "right"
        sample$variable <- factor(sample$variable)
        sqsum[k1] <- as.numeric(kruskal.test(value ~ variable, data = sample)$statistic)
    }
    
    # the first element of this vector is the value of k1 which maximizes sqsum (SKBSQS)
    ord1 <- order(sqsum, decreasing=TRUE)[1]
    
    ############################################################
    # Compute the magnitude of the difference of all distributions in a group
    diff <- function(k, g, av, means){
        negligible <- TRUE
        for(i in k:(g-1)){
            for(j in (i+1):g){
                a <- av$model[av$model[,2] == names(means[k]),1]
                b <- av$model[av$model[,2] == names(means[g]),1]   
                magnitude <- as.character(effsize::cliff.delta(a,b)$magnitude, paired=TRUE)
                if(magnitude != "negligible"){
                    negligible <- FALSE
                }
            }
        }
        return(negligible)
    }
    ############################################################
    
    # if true it returns one node to the right if false it goes forward one node to the left
    if(diff(k, g, av, means) | 
       (ord1 == k)) {
        # In the case of a single average left (maximum)
        if(!diff(k, g, av, means)) {
            # it marks the group to the left consisting of a single mean
            ngroup <- ngroup + 1
            
            # it forms a group of just one mean (the maximum of the group)
            group[k] <- ngroup
            
            # lower limit on returning to the right
            k <- ord1 + 1
        }
        if(diff(k, g, av, means)) {
            # it marks the groups
            ngroup <- ngroup + 1
            
            # it forms a group of means
            group[k:g] <- ngroup
            
            # if this group is the last one
            if (prod(group) > 0)
                # If the upper limit of the latter group formed is equal to the total
                # number of treatments than  the grouping algorithm is ended
                return (group)
            
            # it marks the lower limit of the group of means to be used in the
            # calculation of the maximum sqsum on returning one node to the right
            k <- g + 1
            
            # it marks the upper limit of the group of means to be used in the
            # calculation of the maximum sqsum on returning one node to the right
            g <- markg[g]
        }
        while(k == g) {
            # there was just one mean left to the right, so it becomes a group
            ngroup   <- ngroup + 1
            
            group[g] <- ngroup
            
            if(prod(group) > 0)
                # If the upper limit of the latter group formed is equal to the total
                # number of treatments than  the grouping algorithm is ended
                return(group)
            
            # the group of just one mean group had already been formed, a further
            # jump to the right and another check whether there was just one mean
            # left to the right
            k <- g + 1
            
            g <- markg[g]
        }
    } else {
        # it marks the upper limit of the group split into two to be used on
        # returning to the right later
        markg[ord1] <- g
        
        g <- ord1
    }
    
    PartitionNonParametric(g,
             means,
             mMSE,
             dfr,
             sig.level,
             av,
             k,
             group,
             ngroup,
             markg)
}

OriginalPartition <- function(g,
                     means,
                     mMSE,
                     dfr,
                     sig.level,
                     av,
                     k,
                     group,
                     ngroup,
                     markg,
                     g1=g,
                     sqsum=rep(0, g1))
{
    for(k1 in k:(g-1)) {
        t1 <- sum(means[k:k1])
        
        k2 <- g-k1
        
        t2 <- sum(means[(k1+1):g])
        
        # SK between groups sum of squares
        sqsum[k1] <- t1^2/(k1-k+1) + t2^2/k2 - (t1+t2)^2/(g-k+1)
    }
    
    # the first element of this vector is the value of k1 which maximizes sqsum (SKBSQS)
    ord1 <- order(sqsum, decreasing=TRUE)[1]
    
    # the maximum value of the between groups sum of squares
    b0   <- max(sqsum)
    
    si02 <- (1 / ((g - k + 1) + dfr)) * (sum((means[k:g] - mean(means[k:g]))^2) + dfr * mMSE)
    
    lam  <- (pi / (2 * (pi - 2))) * b0 / si02
    
    valchisq <- qchisq((sig.level),
                       lower.tail=FALSE,
                       df=(g - k + 1) / (pi - 2))
    # if true it returns one node to the right if false it goes forward one node to the left
    if((lam < valchisq) |
       (ord1 == k)) {
        # In the case of a single average left (maximum)
        if(lam > valchisq) {
            # it marks the group to the left consisting of a single mean
            ngroup <- ngroup + 1
            
            # it forms a group of just one mean (the maximum of the group)
            group[k] <- ngroup
            
            # lower limit on returning to the right
            k <- ord1 + 1
        }
        if(lam < valchisq) {
            # it marks the groups
            ngroup <- ngroup + 1
            
            # it forms a group of means
            group[k:g] <- ngroup
            
            # if this group is the last one
            if (prod(group) > 0)
                # If the upper limit of the latter group formed is equal to the total
                # number of treatments than  the grouping algorithm is ended
                return (group)
            
            # it marks the lower limit of the group of means to be used in the
            # calculation of the maximum sqsum on returning one node to the right
            k <- g + 1
            
            # it marks the upper limit of the group of means to be used in the
            # calculation of the maximum sqsum on returning one node to the right
            g <- markg[g]
        }
        while(k == g) {
            # there was just one mean left to the right, so it becomes a group
            ngroup   <- ngroup + 1
            
            group[g] <- ngroup
            
            if(prod(group) > 0)
                # If the upper limit of the latter group formed is equal to the total
                # number of treatments than  the grouping algorithm is ended
                return(group)
            
            # the group of just one mean group had already been formed, a further
            # jump to the right and another check whether there was just one mean
            # left to the right
            k <- g + 1
            
            g <- markg[g]
        }
    } else {
        # it marks the upper limit of the group split into two to be used on
        # returning to the right later
        markg[ord1] <- g
        
        g <- ord1
    }
    
    OriginalPartition(g,
             means,
             mMSE,
             dfr,
             sig.level,
             av,
             k,
             group,
             ngroup,
             markg)
}