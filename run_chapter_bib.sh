#!/bin/bash
# If using chapterbib, compile your thesis in the following progression:
pdflatex thesis.tex

bibtex chapter1.aux
bibtex chapter2.aux

pdflatex thesis.tex
pdflatex thesis.tex
