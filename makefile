name = usage
viewer = chrome.exe

.PHONY: clean
clean:
	-rm *.aux
	-rm *.log
	-rm *.toc

.PHONY: run2
run2:
	xelatex $(name).tex
	xelatex $(name).tex

.PHONY: run
run:
	xelatex $(name).tex

.PHONY: look
look:
	$(viewer) $(name).pdf

.PHONY: fuck
fuck: run2 look

