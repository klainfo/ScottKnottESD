#' @name "check.ANOVA.assumptions"
#' @title Check basic ANOVA assumptions
#'
#' @description  Check the normality assumption of the input dataset using the Shapiro test and the homogeneity of variances assumption of the input dataset using the Levene's test.
#'
#' @author Chakkrit Tantithamthavorn (kla@chakkrit.com)
#' 
#' @param x A wide-format data frame.
#' @param alpha The significance level.
#' @param ... Optional parameters.
#' 
#' @return A wide-format data frame.
#' 
#' @examples
#' check.ANOVA.assumptions(example)
#' 
#' @import car
#' @import stats
#' @rdname check.ANOVA.assumptions
#' @export 
"check.ANOVA.assumptions" <- function(x, alpha=0.05, ...){
    x <- data.frame(x)        
    # Check the normality assumption of the input dataset using the Shapiro test
    normality.pvalue <- apply(x, 2, function(x) stats::shapiro.test(x)$p.value)
    # Check the homogeneity of variances assumption of the input dataset using the Levene's test
    homogeneity.pvalue <- car::leveneTest(value ~ variable, data=reshape2::melt(x, id.vars=0))$`Pr(>F)`[1]
    # car::leveneTest(value ~ variable, data=reshape2::melt(x, id.vars=0))
    # stats::bartlett.test(value ~ variable, data=reshape2::melt(x, id.vars=0))
    
    # Only produce warnings when the input data does not meet the basic ANOVA assumptions.
    if(length(normality.pvalue[normality.pvalue < alpha]) > 0 | homogeneity.pvalue < alpha){
        message("WARNING: The input data does not meet the basic ANOVA assumptions. The results should be interpreted with caution.")
        if(length(normality.pvalue[normality.pvalue < alpha]) > 0){
            # p-value > alpha = the distributions are normal. We fail to reject H0.
            # p-value < alpha = the distributions are non-normality. 
            message("[-] The following variables of the input data are not normally distributed.")
            message(paste0("   ",paste0(names(normality.pvalue[normality.pvalue >= alpha]),"(p=",round(normality.pvalue[normality.pvalue >= alpha],4),")", collapse = ", ")))
        }
        if(homogeneity.pvalue < alpha){
            # p-value > alpha = the variances among treatments are homogeneous. We fail to reject H0.
            # p-value < alpha = the variances among treatments are not homogeneous.
            message(paste0("[-] The variances among variables are not homogeneous.","(p=",round(homogeneity.pvalue,4),")"))
        }
    }else{
        print("The input data meets the basic ANOVA assumptions.")
    }
}