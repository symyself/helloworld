#!/bin/env python2.7
#! -*- coding: UTF-8 -*-
def everyday_2015_11_22():
    for i in range(1,10):
        for j in range(1,i+1):
            print '%dx%d=%-2d'%(i,j,i*j),
        print

    letter='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    for char in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ':
        print letter
        letter=letter[1:]+char

def everyday_2015_11_12():
    s=[1,4,5,7,1,7,54,3,67,3,3,89]
    print s
    s.sort()
    print s
    print list(set(s))
    print [ i for i in s if s.count(i) ==1 ]

if __name__=='__main__':
    everyday_2015_11_22()
    everyday_2015_11_12()
