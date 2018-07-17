#
# Prefer the submodule to an externally defined TEXMFHOME
#
LOCAL=lsst-texmf/texmf

# List of tex files used to build the document
tex=$(filter-out $(wildcard *acronyms.tex) , $(wildcard *.tex)) docs/*tex docs/*/*tex

all: LDM-230.pdf

LDM-230.pdf:  $(tex) acronyms.tex
	if [ -d "${LOCAL}" ]; then \
	  export TEXMFHOME="${LOCAL}"; \
	  latexmk -bibtex -pdf -f LDM-230.tex; \
	else \
	  latexmk -bibtex -pdf -f LDM-230.tex; \
	fi


acronyms.tex: $(tex) myacronyms.txt
	if [ -d "$(LOCAL)" ]; then \
	  "$(LOCAL)/../bin/generateAcronyms.py" $(tex); \
	else \
	  generateAcronyms.py $(tex); \
	fi
