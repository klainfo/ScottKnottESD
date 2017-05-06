doc:
	R -e "devtools::document()"
build:
	R -e "devtools::build()"
install:
	R -e "devtools::install_github('klainfo/ScottKnottESD')"
install_local:
	R CMD INSTALL .
check:
	R -e "devtools::check()"