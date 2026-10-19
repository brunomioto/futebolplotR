# nocov start
.onLoad <- function(libname, pkgname) {
  # registers the S7 method of element_grob for element_futebol_badge
  S7::methods_register()
}
# nocov end
