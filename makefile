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

.PHONY: funk
fuck: run look

.PHONY: fuck2
fuck2: run2 look

