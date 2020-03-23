#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
__author__ = 'LiBin'
__mtime__ = '2017/2/25'
			  ┏┓   ┏┓
			 ┏┛┻━━━┛┻┓
			 ┃   ☃    ┃
			 ┃ ┳┛  ┗┳  ┃
			 ┃    ┻    ┃
			 ┗━┓      ┏━┛
			  ┃       ┗━━━┓
			  ┃  神兽保佑  ┣┓
			  ┃　永无BUG！ ┏┛
			  ┗┓┓┏━┳┓┏┛
			   ┃┫┫ ┃┫┫
			   ┗┻┛ ┗┻┛
"""
from optparse import OptionParser
from par_har import *
from suite import *

import os

if __name__ == '__main__':

    parser = OptionParser()
    parser.add_option(
        "-f",
        "--HarFile",
        action="store",
        type="string",
        dest="harfile",
        help="Please input dir file har file")
    parser.add_option(
        "-o",
        "--RfFile",
        action="store",
        type="string",
        dest="rffile",
        help="Please input dir output rf file")
    parser.add_option(
        "-e",
        "--Email",
        action="store",
        type="string",
        dest="email",
        help="Please input email")
    parser.add_option(
        "-p",
        "--PassWd",
        action="store",
        type="string",
        dest="passwd",
        help="Please input passwd")

    (options, args) = parser.parse_args()

    if options.harfile is None or options.rffile is None or options.email is None or options.passwd is None:
        parser.print_help()
        quit()
    if not os.path.exists(options.harfile):
        print('Har file %s not exist' % options.harfile)
        quit()

    suite = Parse(options.harfile, options.rffile, options.email, options.passwd)
    save = Save(options.rffile)
    save.new_suite()
    suite.run()
# python run.py -f C:\Users\Administrator\Desktop\192.168.1.9.har -o ..\artest\TestCase\init\2.txt -e 2096147163@qq.com -p qwer123456789
