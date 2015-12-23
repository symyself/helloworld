#!/bin/env python2.7
#! -*- coding: UTF-8 -*-
class User():
    def __init__(self,id,name):
        self.id = id
        self.name = name

    def rename(self,new_name):
        self.name = new_name
    def __repr__( self ):
        return 'User id:%s name:%s' %(self.id,self.name)

s=User(1,'songy')
y=User(2,'yangs')
print s,y
User.rename(s,'songyang')
print s,y

#著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。作者：李保银链接：http://www.zhihu.com/question/20021164/answer/18224953来源：知乎
IND = 'ON'
def checkind():
    return (IND == 'ON')
class Kls(object):
    def __init__(self,data):
        self.data = data
    def do_reset(self):
        if checkind():
            print('Reset done for:', self.data)
    def set_db(self):
        if checkind():
            self.db = 'new db connection'
            print('DB connection made for:',self.data)
ik1 = Kls(12)
ik1.do_reset()
ik1.set_db()
