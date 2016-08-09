#' Print sk_esd objects
#'
#' S3 method to print sk_esd objects.
#'
#' @param x A sk_esd object
#' @param ... Optional parameters.
#' 
#' @return The sk.esd ranks
#' 
#' @rdname print
#' @method print sk_esd
#' @export
print.sk_esd <- function(x, ...){
    cat("\nGroups:\n")
    print(x$groups)
}
