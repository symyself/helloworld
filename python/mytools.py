#!/bin/env python2.7
#! -*- coding: UTF-8 -*-
def name():
    print 'songy'
    print 'symyself@163.com'

def exec_str(info,cmd):
    print "%20s:%15s\t= %r" %(info,cmd,eval(cmd))
def useful_func():
    print '常用的内置函数'
    exec_str('int[0,256) to char','chr(48)')
    exec_str('char to int','ord("0")')
    exec_str('10 to 2','bin(24)')
    exec_str('10 to 8','oct(24)')
    exec_str('10 to 16','hex(24)')
    exec_str('2 to 10','int("0b11000",2)')
    exec_str('8 to 10','int("030",8)')
    exec_str('16 to 10','int("0x18",16)')
if __name__ == "__main__":
    useful_func()
