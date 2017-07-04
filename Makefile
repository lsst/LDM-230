#
#

LDM-230.pdf:  *.tex */*.tex */*/*.tex
	latexmk -bibtex -pdf -f LDM-230.tex
