#!/bin/env python2.7
#! -*- coding: UTF-8 -*-
import my_func
import unittest

class ut( unittest.TestCase ):
    def setUp(self):
        pass
    def tearDown(self):
        pass
    def test_sum(self):
        self.assertEqual( my_func.sum(1,2),3,'test sum fial');
    def test_sub(self):
        self.assertEqual( my_func.sub(2,1),1,'test sub fail');

if __name__ == '__main__':
    unittest.main(verbosity=2)
