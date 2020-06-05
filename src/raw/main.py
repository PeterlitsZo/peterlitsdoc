#!/usr/bin/python3

import sys
sys.path.append("..")
import TPL.holder

tpl_file = TPL.holder.Holder("makefile.tpl.tpl")
tpl_file.interter()

tpl_file = TPL.holder.Holder("cls.tpl.tpl")
tpl_file.interter()
