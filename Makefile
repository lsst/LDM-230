#
export TEXMFHOME = lsst-texmf/texmf

#

tex=$(filter-out $(wildcard *acronyms.tex) , $(wildcard *.tex)) */*tex */*/*tex

LDM-230.pdf:  *.tex */*.tex */*/*.tex
	latexmk -bibtex -pdf -f LDM-230.tex

acronyms.tex :$(tex) myacronyms.txt
	python3 ${TEXMFHOME}/../bin/generateAcronyms.py   $(tex)


