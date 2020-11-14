
.SUFFIXES : .pdf .tex .zip

# LATEX=pdflatex
LATEX=xelatex
# CP_TARGET=$(HOME)/Documents/personal/goodreader\ docs/doolin
CP_TARGET=/tmp

TEXINPUTS := ${TEXINPUTS}:`pwd`/..
#test:
#	@echo ${TEXINPUTS}

TEXFILES = $(wildcard ../*.tex)

ZIPS = bst.zip

PDFS = bst.pdf examples.pdf hash_tree.pdf sedgewick.pdf tikz.pdf

pdfs: $(PDFS)

zips: $(ZIPS)

bst: bst.pdf

# PREAMBLE = ../preamble.tex

# %.pdf: %.tex $(PREAMBLE) $(TEXFILES) phphook.tex thesis16.tex
%.pdf: %.tex
	$(LATEX) $*
	bibtex	$*
	$(LATEX) $*
	$(LATEX) $*
	cp $*.pdf $(CP_TARGET)


# %.zip: %.tex preamble.tex
%.zip: %.tex
	$(LATEX) $*
	bibtex	$*
	$(LATEX) $*
	$(LATEX) $*
	zip $* $*.pdf



1: bst.zip
#	pdflatex bst
#	zip bst bst.pdf

clean:
	rm -f  *.dvi *.toc *.bbl *.log *.aux *.blg *~ sblock.75.ps\
         *.lof *.fff *.lot *.out *.zip *.pdf *.bak *.gz\
         __latexindent_temp.tex *.fdb_latexmk *.fls

spotless: clean
#	cd figs; $(MAKE) spotless
	rm -f  sblock.ps sblock.75.ps *.lof *.fff  *.out *.pdf
