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
from define import *
from suite import *
from tqdm import *
from robot.parsing import TestData

import json
import base64


class Parse(object):

    def __init__(self, path, rfpath, email, passwd):
        self.__path = path
        self.__rf_pth = rfpath
        self.__data = None
        self.__url_list = []
        self.__err_name = u'(看这里接口报错了%s)'
        self.__email = email
        self.__passwd = passwd

    def __source(self):
        with open(self.__path, mode='r', encoding='UTF-8') as file_data:
            self.__data = json.load(file_data)['log']['entries']

    def __headers(self, data):
        headers = {}
        for each in data:
            k, v = each.values()
            if k in ['Cookie']:
                continue
            headers.setdefault(k, v)
        return headers

    def __post_data(self, post_data):
        data = {}
        for each in post_data:
            k, v = each.values()
            data.setdefault(k, v)
        return data

    def __base64decode(self, text):
        missing_padding = 4 - len(text) % 4
        if missing_padding:
            text += b'=' * missing_padding
        return base64.decodestring(text)

    def __par(self):
        num = 1
        for each in tqdm(self.__data):
            name = 'a'
            name += str(num)
            request = each['request']
            response = each['response']
            headers = self.__headers(request['headers'])
            url = request['url']
            if url in self.__url_list:
                continue
            self.__url_list.append(url)
            method = request['method']

            postData = {}
            if method == "POST":
                if 'params' in request['postData']:
                    postData = self.__post_data(request['postData']['params'])
                elif 'text' in request['postData']:
                    text = request['postData']['text']
                    try:
                        postData = json.loads(text)
                    except:
                        postData = text
            status = response['status']
            if status > 200:
                name += self.__err_name % str(status)
            content = response['content']['text'].replace('null', 'None')
            args = ["{'email': %s, 'passwd': %s}" % (self.__email, self.__passwd),
                    url, method, "headers=%s" % json.dumps(headers), "data=%s" % json.dumps(postData)]
            DATA['case_steps'][0]['args'] = args
            DATA['name'] = name

            test_data = TestData(source=self.__rf_pth)
            Save.suite_save(DATA, test_data)
            num += 1

    def run(self):
        self.__source()
        self.__par()
