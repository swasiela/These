SHELL := /bin/bash # Use bash function, so might as well

NORMAL_FILE=thesis-workdoc
ANNOTATE_PRINT_FILE=thesis-workdoc-print-annotate
PRINT_FILE=thesis-print
PDF_FILE=thesis-digital

pdf: FORCE
	latexmk -lualatex -shell-escape -silent main.tex && mv main.pdf $(NORMAL_FILE).pdf
	. ./utils/pdf_functions.bash; pdf_compress $(NORMAL_FILE).pdf && mv $(NORMAL_FILE)-compress.pdf $(NORMAL_FILE).pdf

pdf-annotate: FORCE
	latexmk -lualatex -shell-escape -silent -pretex='\def\annotateprint{}' -usepretex main.tex && mv main.pdf $(ANNOTATE_PRINT_FILE).pdf
	. ./utils/pdf_functions.bash; pdf_compress_norot $(ANNOTATE_PRINT_FILE).pdf && mv $(ANNOTATE_PRINT_FILE)-compress.pdf $(ANNOTATE_PRINT_FILE).pdf

# Will disable externalization as it supposed to be the final version, this way we avoid any potential issues
pdf-final-print: FORCE
	latexmk -lualatex -shell-escape -silent -pretex='\def\isfinal{}\def\finalprint{}' -usepretex main.tex && mv main.pdf $(PRINT_FILE).pdf
	. ./utils/pdf_functions.bash; pdf_compress_norot $(PRINT_FILE).pdf && mv $(PRINT_FILE)-compress.pdf $(PRINT_FILE).pdf

# Will disable externalization as it supposed to be the final version, this way we avoid any potential issues
pdf-final: FORCE
	latexmk -lualatex -shell-escape -silent -pretex='\def\isfinal{}' -usepretex main.tex && mv main.pdf $(PDF_FILE).pdf
	. ./utils/pdf_functions.bash; pdf_compress $(PDF_FILE).pdf && mv $(PDF_FILE)-compress.pdf $(PDF_FILE).pdf

all: pdf pdf-annotate

all-final: pdf-final pdf-final-print

mainpdf: FORCE
	latexmk -lualatex -synctex=1 -shell-escape -silent main.tex
	. ./utils/pdf_functions.bash; pdf_compress main.pdf && mv main-compress.pdf main.pdf



pdf-watermark: FORCE
	latexmk -lualatex -shell-escape -silent -pretex='\def\watermark{}' -usepretex main.tex && mv main.pdf $(NORMAL_FILE)-watermark.pdf
	. ./utils/pdf_functions.bash; pdf_compress $(NORMAL_FILE)-watermark.pdf && mv $(NORMAL_FILE)-watermark-compress.pdf $(NORMAL_FILE)-watermark.pdf

clean: FORCE
	latexmk -c -bibtex main.tex
	rm -f $(NORMAL_FILE).pdf $(ANNOTATE_PRINT_FILE).pdf
	rm -r ./_minted* || true


FORCE: