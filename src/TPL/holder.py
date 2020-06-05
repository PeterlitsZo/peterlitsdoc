

class NeedInput(object):
    pass


class Holder(object):
    def __init__(self, path: str):
        self._file = open(path, "r")
        self._arglist = dict()
        self._filename = "tpl_out"
        self._content = ""

    def _cleararg(self, string: str) -> str:
        """it is import to clear the begin and end whitespace, before parser it
        , so this function will make string throw its whitespace at the begining
        and the end place"""
        return string.strip()

    def _dealarg(self, argument: str) -> str or NeedInput:
        """this will make a string be a str or just a NeedInput, I assert that
        the NeedInput's format is like: input, and the str is like "str"."""
        if argument == "input":
            return NeedInput()
        else:
            return str(eval(argument))

    def _lineparser(self) -> (bool, str, ):
        """this function will parser a line a the begining."""
        argline = self._file.readline()
        if argline.startswith("/"):
            #it mean that the tpl's arglist is at the end
            flag, argname, argvalue = False, None, None
        else:
            # else I assert its format is like:
            #     argname / argvalue
            flag = True
            argname, argvalue = argline.split("/", 1)
            argname = self._cleararg(argname)
            argvalue = self._dealarg(self._cleararg(argvalue))
        return flag, argname, argvalue

    def _parser(self):
        """this function will parser arglist line by line."""
        flag = True
        flag, argname, argvalue = self._lineparser()
        while(flag):
            self._arglist[argname] = argvalue
            flag, argname, argvalue = self._lineparser()

        if "__filename__" in self._arglist:
            self._filename = self._arglist["__filename__"]

    def _input(self):
        """ this will clear all NeedInput argline"""
        self._parser()
        arglist = self._arglist
        for key in self._arglist:
            # loop the arglist and make all need input argument be inputed
            value = self._arglist[key]
            if type(value) == NeedInput:
                value = input("\n PLEASE ENTER:\n     " + key + "\n > ")
            arglist[key] = value
        # make it be a inputed arglist
        self._arglist = arglist

    def _make(self):
        #assert that the pointer is now under the arglines
        self._content = self._file.read()
        for key in self._arglist:
            self._content = self._content.replace(
                "{%" + key + "%}", self._arglist[key]
            )

    def interter(self):
        """ use interter mode to Holder tpl file"""
        self._input()
        self._make()
        with open(self._filename, "w") as outer:
            outer.write(self._content)

