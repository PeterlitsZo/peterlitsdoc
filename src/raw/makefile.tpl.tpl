__filename__/ "../makefile.tpl"
/------------------------------------------------------------------------------
_/
_/  "--------Meta data--------------------------------------------------------"
_/
    __filename__/ "makefile"
_/
    the name of the main tex file(with out the extand)/ input
_/
    viewer to view the PDF file/ input
_/
_/  "--------Debug mode-------------------------------------------------------"
_/
    need debug(enter [y or n])/ input
_/
_/  "--------if need debug----------------------------------------------------"
_/
    if need debug part 1/ "echo '\\directlua{require(\"drawboxes\")}'>> $(name).tex"
    if need debug part 2/ "\n\techo '\\usepackage{graphicx,atbeginshi}' >> $(name).tex"
    if need debug part 3/ "\n\techo '' >> $(name).tex"
    if need debug part 4/ "\n\techo '\\AtBeginShipout{\\directlua{drawboxes.vi"
    if need debug part 4/ {!if need debug part 4!}"sual_debug()}}' >> $(name).tex"
_/
    if need debug/                 {!if need debug part 1!}
    if need debug/{!if need debug!}{!if need debug part 2!}
    if need debug/{!if need debug!}{!if need debug part 3!}
    if need debug/{!if need debug!}{!if need debug part 4!}
_/
_/  "--------if do not need debug---------------------------------------------"
_/
    if do not need debug / "echo '' >> $(name).tex" 
_/
    debug part/ {!if need debug!} if {!need debug(enter [y or n])!} == "y" else {!if do not need debug!}
    nondebug remove/ "drawboxes.lua" if {!need debug(enter [y or n]!} != "y" else ""
/------------------------------------------------------------------------------

name = {%the name of the main tex file(with out the extand)%}
viewer = {%viewer to view the PDF file%}

.PHONY: afterinstall
afterinstall:
	rm -rf TPL *.tpl main.py *.tar {%nondebug remove%}
	echo '\\documentclass{peterlitsdoc}' > $(name).tex
	{%debug part%}
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

