mainpart = cls.tpl makefile.tpl main.py TPL

.PHONY:makesrc
makesrc:
	cd ./src/raw && python3 ./main.py
	cd ./src && tar -cf ../peterlitsdoc.tar $(mainpart)

