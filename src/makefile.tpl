__filename__/ "makefile"
the name of the main tex file(with out the extand)/ input
viewer to view the PDF file/ input


/------------------------------------------------------------------------------

name = {%the name of the main tex file(with out the extand)%}
viewer = {%viewer to view the PDF file%}

.PHONY: clean
clean:
	-rm *.aux
	-rm *.log
	-rm *.toc
	-rm *.out

.PHONY: run
run2:
	xelatex $(name).tex

.PHONY: run2
run:
	xelatex $(name).tex
	xelatex $(name).tex

.PHONY: look
look:
	$(viewer) $(name).pdf

.PHONY: funk
fuck: run look

.PHONY: fuck2
fuck2: run2 look

