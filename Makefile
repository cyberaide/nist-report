UNAME := $(shell uname)

ifeq ($(UNAME), Darwin)
OPEN=open
endif
ifeq ($(UNAME), Linux)
OPEN=xdg-open
endif



FILE=report

all:
	pdflatex ${FILE}
	bibtex ${FILE}
	pdflatex ${FILE}
	pdflatex ${FILE}

real-clean: clean
	rm -rf *.pdf

clean:
	rm -rf *~ *.aux *.bbl *.dvi *.log *.out *.blg *.toc *.fdb_latexmk *.fls *.tdo *.bcf

view:
	$(OPEN) ${FILE}.pdf

# all dependce tracking taking care of by Latexmk
fast:
	latexmk -pdf ${FILE}

watch:
	latexmk -pvc -view=pdf ${FILE}

todo:
	egrep -nH --color=auto "FIXME|TODOj" *.tex

.PHONY: all clean view fast watch
