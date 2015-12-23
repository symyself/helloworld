#!/bin/env python2.7
#! -*- coding: UTF-8 -*-
import functools
'''
learn decorator
'''
'''示例1: 最简单的函数,表示调用了两次'''

def func0():
    print 'func0 print this'

'''示例2: 替换函数(装饰)
装饰函数的参数是被装饰的函数对象，返回原函数对象
装饰的实质语句: myfunc = deco(myfunc)'''
def decorator1(func):
    print 'before func .'
    func()
    print 'after func ..'
    return func

'''示例3: 使用语法糖@来装饰函数，相当于“myfunc = deco(myfunc)”
但发现新函数只在第一次被调用，且原函数多调用了一次'''
@decorator1
def func1():
    print 'func1 print this'

'''示例4: 使用内嵌包装函数来确保每次新函数都被调用，
内嵌包装函数的形参和返回值与原函数相同，装饰函数返回内嵌包装函数对象'''
def decorator2( func ):
    def _in_decorator():
        print 'before func do something...'
        func()
        print 'after func do something...'
    return _in_decorator

@decorator2
def func2():
    print 'func2 print this'

'''示例5: 对带参数的函数进行装饰，
内嵌包装函数的形参和返回值与原函数相同，装饰函数返回内嵌包装函数对象'''
def decorator3(func):
    def _in_decorator(name,age):
        print 'before func do something...'
        ret =  func( name,age)
        print 'after func do something...'
        return ret
    return _in_decorator

@decorator3
def func3(name,age):
    print 'my name is %s , i am %d years old!' %(name,age)

'''示例6: 对参数数量不确定的函数进行装饰，
参数用(*args, **kwargs)，自动适应变参和命名参数'''
def decorator4( func ):
    def _in_decorator( *args,**kwargs):
        print 'before %s do something'%func.__name__
        ret=func( *args,**kwargs)
        print 'after %s do something'%func.__name__
        return ret
    return _in_decorator

@decorator4
def func4( *args,**kwargs):
    print sum(args)
    if 'name' in kwargs:
        print 'my name is %s'%kwargs['name']
    if 'age' in kwargs:
        print 'i am %d years old'%kwargs['age']

'''示例7: 在示例4的基础上，让装饰器带参数，
和上一示例相比在外层多了一层包装。
装饰函数名实际上应更有意义些'''

def decorator7( d_args ):
    def _in_decorator( func ):
        #@functools.wraps( func )
        @functools.wraps( func )
        def _in_in_decorator( a , b , *args , **kwargs ):
            '''
            doc for _in_in_decorator
            '''
            print 'before %s do something : %s' %(func.__name__,d_args)
            ret=func( a,b,*args,**kwargs )
            print 'after %s do something : %s' %(func.__name__,d_args)
            return ret
        return _in_in_decorator
    return _in_decorator

@decorator7( 777 )
def func7( a,b,*args,**kwargs):
    '''
    doc for func7
    '''
    print a,b
    print args
    print kwargs


if __name__ == "__main__":
    ###print 'test 1'
    ###func1()
    ###func1()

    ###print 'test 2'
    #func2=decorator1( func1)
    ###func2()
    ###func2()

    #print 'test 3'
    #func3()
    #func3()
    func2()

    func3('songy',18)
    func3('songy',19)

    func4(1,2,3,4,name='songyangg')
    func4(1,2,3,4,5,6,age=20,name='songyangg')
    func7(1,3,1,2,3,4,age=20,year=2015)
    print func7.__name__
    print func7.__doc__
    print func7.__dict__
    print func7.__module__

