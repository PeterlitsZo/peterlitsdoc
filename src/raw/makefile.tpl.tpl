__filename__/ "../makefile.tpl"
/------------------------------------------------------------------------------
__filename__/ "makefile"
the name of the main tex file(with out the extand)/ input
viewer to view the PDF file/ input
/------------------------------------------------------------------------------

name = {%the name of the main tex file(with out the extand)%}
viewer = {%viewer to view the PDF file%}

.PHONY: afterinstall
afterinstall:
	rm -rf TPL *.tpl main.py
	echo "\\documentclass{peterlitsdoc}" > $(name).tex
	echo "" >> $(name).tex
	echo "\\begin{document}" >> $(name).tex
	echo "\\end{document}" >> $(name).tex

.PHONY: clean
clean:
	-rm *.aux
	-rm *.log
	-rm *.toc
	-rm *.out

.PHONY: run
run:
	lualatex $(name).tex

.PHONY: run2
run2:
	lualatex $(name).tex
	lualatex $(name).tex

.PHONY: look
look:
	$(viewer) $(name).pdf

.PHONY: funk
fuck: run look

.PHONY: fuck2
fuck2: run2 look

