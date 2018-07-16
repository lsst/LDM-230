#
#You may already have this defined in your env and it may not be what's in travis
TEXMFHOME ?= lsst-texmf/texmf

#

tex=$(filter-out $(wildcard *acronyms.tex) , $(wildcard *.tex)) docs/*tex docs/*/*tex

all: LDM-230.pdf

LDM-230.pdf:  $(tex) acronyms.tex
	latexmk -bibtex -pdf -f LDM-230.tex

acronyms.tex: $(tex) myacronyms.txt
	echo ${TEXMFHOME}
	python3 ${TEXMFHOME}/../bin/generateAcronyms.py   $(tex)
