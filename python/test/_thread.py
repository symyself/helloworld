#!/bin/env python2.7
#! -*- coding: UTF-8 -*-

from threading import Thread
import time

def thread_func( threadid ):
    for i in range(5):
        time.sleep(threadid)
        print 'I am in thread %d' %threadid

def start_thread( threadid):
    thr = Thread( target=thread_func , args=[threadid])
    thr.start()
    return thr

if __name__ == '__main__':
    start_thread(1)
    start_thread(2)
    start_thread(3)
    start_thread(4)

