#!/bin/env python2.7
#! -*- coding: UTF-8 -*-
import logging
import logging.config
from datetime import datetime

logging.config.fileConfig("logger.conf")
register_logger = logging.getLogger("register")
login_logger = logging.getLogger("login")

tab='\t'
msglist=[ datetime.now().strftime('%F %T'),'songyang','ios','192.168.1.218']
message=tab.join( msglist )

register_logger.info(message)
register_logger.info(message)
login_logger.info(message)

'''
import logging
import logging.handlers

LOG_FILE = 'tst.log'

handler = logging.handlers.RotatingFileHandler(LOG_FILE, maxBytes = 1024*1024, backupCount = 5) # 实例化handler
fmt = '%(asctime)s - %(filename)s:%(lineno)s - %(name)s - %(message)s'

formatter = logging.Formatter(fmt)   # 实例化formatter
handler.setFormatter(formatter)      # 为handler添加formatter

logger = logging.getLogger('tst')    # 获取名为tst的logger
logger.addHandler(handler)           # 为logger添加handler
logger.setLevel(logging.DEBUG)

logger.info('first info message')
logger.debug('first debug message')
'''

class mylogger():
    def __init__(self,endpoint):
        self.logger = logging.getLogger( endpoint )
        self.logfile = endpoint+'.log'
        self.handler = logging.handlers.TimedRotatingFileHandler(self.logfile,when='h', interval=1)
        self.fmt = '%(asctime)s\t%(name)s\t%(message)s'
        self.formatter = logging.Formatter( self.fmt )
        self.handler.setFormatter( self.formatter )
        self.logger.addHandler( self.handler )
        self.logger.setLevel( logging.INFO )

    def info(self,message=None):
        self.logger.info( message )

a = mylogger( 'auth.login')
a.info('a login')
b = mylogger('main.index')
b.info('index')
c = mylogger('user.info')
c.info('test no arg')
