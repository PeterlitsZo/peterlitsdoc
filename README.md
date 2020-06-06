# peterlitsdoc

LaTeX cls file for Chinese document

Get `usage.pdf` for more infomation.

下载`usage.pdf`以获得更多信息。

## How to use?

Run this command to get useful part.

```
wget https://github.com/PeterlitsZo/peterlitsdoc/releases/download/v0.2.0/peterlitsdoc.tar
tar -xf peterlitsdoc.tar
python3 main.py
make afterinstall
```

运行上面的命令，下载、解压、从模板生成文件、清理文件。
生成`cls`文件（格式定义）和`makefile`文件（快捷命令）。

## About makefile

Set your variable. Edit file `makefile` and change the first two
lines: `name` is your file's name and `viewer` is the tool to watch.

Enter `make <command>` for:

```
<command>:
afterinstall- clean the .tpl file and touch the $(name).tex
clean       - clean all files useless - 清除所有没有用的文件
run         - run xelatex to get the pdf file.
run2        - run twice
look        - use viewer to look your pdf file
fuck        - `run` and then `look`
fuck2       - `run2` and then `look`
```

