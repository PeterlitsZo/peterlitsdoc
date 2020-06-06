
name = usage
viewer = chrome.exe

.PHONY: afterinstall
afterinstall:
	rm -rf TPL *.tpl main.py *.tar 
	echo '\\documentclass{peterlitsdoc}' > $(name).tex
	echo '\directlua{require("drawboxes")}'>> $(name).tex
	echo '\usepackage{graphicx,atbeginshi}' >> $(name).tex
	echo '' >> $(name).tex
	echo '\AtBeginShipout{\directlua{drawboxes.visual_debug()}}' >> $(name).tex
	echo '\\begin{document}' >> $(name).tex
	echo '\\end{document}' >> $(name).tex

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

