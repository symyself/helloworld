#!/bin/env python2.7
#! -*- coding: UTF-8 -*-
def name():
    print 'songy'
    print 'symyself@163.com'

def useful_func():
    def exec_str(info,cmd):
        print "%20s:%15s\t= %r" %(info,cmd,eval(cmd))
    print '常用的内置函数'
    exec_str('int[0,256) to char','chr(48)')
    exec_str('char to int','ord("0")')
    exec_str('10 to 2','bin(24)')
    exec_str('10 to 8','oct(24)')
    exec_str('10 to 16','hex(24)')
    exec_str('2 to 10','int("0b11000",2)')
    exec_str('8 to 10','int("030",8)')
    exec_str('16 to 10','int("0x18",16)')

def is_chinese(uchar):
    '''判断一个unicode是否是汉字'''
    if uchar >= u'\u4e00' and uchar<=u'\u9fa5':
        return True
    else:
        return False

def is_number(uchar):
    """判断一个unicode是否是数字"""
    if uchar >= u'\u0030' and uchar<=u'\u0039':
        return True
    else:
        return False

def is_alphabet(uchar):
    """判断一个unicode是否是英文字母"""
    if (uchar >= u'\u0041' and uchar<=u'\u005a') or (uchar >= u'\u0061' and uchar<=u'\u007a'):
        return True
    else:
        return False

def is_other(uchar):
    """判断是否非汉字，数字和英文字符"""
    if not (is_chinese(uchar) or is_number(uchar) or is_alphabet(uchar)):
        return True
    else:
        return False

if __name__ == "__main__":
    useful_func()
