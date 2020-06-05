#!/usr/bin/python3

import TPL.holder

tpl_file = TPL.holder.Holder("makefile.tpl")
tpl_file.interter()

tpl_file = TPL.holder.Holder("cls.tpl")
tpl_file.interter()
