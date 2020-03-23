#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
__author__ = 'LiBin'
__mtime__ = '16/6/13'
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

import json
import requests
import time
import hashlib
import random
import pymysql

__version__ = '0.1'


class PublicLibrary(object):

    def __int__(self):
        pass

    def getCoding(self, strInput):
        u"""
        获取编码格式
        """
        if isinstance(strInput, unicode):
            return "unicode"
        try:
            strInput.decode("utf8")
            return 'utf8'
        except:
            pass
        try:
            strInput.decode("gbk")
            return 'gbk'
        except:
            pass

    def tran2UTF8(self, strInput):
        """
        转化为utf8格式
        """
        strCodingFmt = self.getCoding(strInput)
        if strCodingFmt == "utf8":
            return strInput
        elif strCodingFmt == "unicode":
            return strInput.encode("utf8")
        elif strCodingFmt == "gbk":
            return strInput.decode("gbk").encode("utf8")

    def tran2GBK(self, strInput):
        """
        转化为gbk格式
        """
        strCodingFmt = self.getCoding(strInput)
        if strCodingFmt == "gbk":
            return strInput
        elif strCodingFmt == "unicode":
            return strInput.encode("gbk")
        elif strCodingFmt == "utf8":
            return strInput.decode("utf8").encode("gbk")

    def md5(self, init_str):
        """
        md5加密
        """
        m = hashlib.md5()
        m.update(init_str)

        return m.hexdigest()

    def eval_dict(self, strInput):
        u"""接收字符串直接转成需要类型,例
         | eval dict                   | str                |
        """
        strInput = eval(strInput)

        return strInput

    def random_num(self, num):
        """
        随机出给出数字位数的数字
        """
        number = ''
        for i in random.sample(range(10), int(num)):
            number += ''.join(str(i))

        return number

    def req(
            self,
            login_msg,
            url,
            method,
            data=None,
            headers=None):
        u"""专用,有登录状态,例
         | run interface test tenant  | login_msg,url,method,data,headers
        """
        session = requests.Session()
        url = self.tran2UTF8(url)
        method = self.tran2UTF8(method)
        if login_msg:
            login_msg = self.eval_dict(login_msg)
            md5_pwd = self.md5(login_msg['passwd'])
            login_msg['passwd'] = md5_pwd
        if data:
            data = self.eval_dict(data)
        if headers:
            headers = self.eval_dict(headers)
        else:
            headers = {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        results = 'connection error'
        # 先登录
        r = session.post('https://xxxxxx.cn/login',
                         data=json.dumps(login_msg), headers=headers)
        print ("*******************************")
        print (u"登录状态信息")
        print (r.status_code)
        print (r.content)
        print ("*******************************")
        try:
            if method == "post":
                if isinstance(data, dict):
                    data = json.dumps(data)
                results = session.post(
                    url, data=data, headers=headers, verify=False)
            elif method == "get":
                results = session.get(
                    url, params=data, headers=headers, verify=False)
            elif method == 'delete':
                results = session.delete(url, headers=headers, verify=False)

            return results
        except requests.ConnectionError as e:
            return e

    def con_db(self, sql):
        db = pymysql.connect(
            host="1.1.5.2",
            user="xxx",
            passwd="xxx",
            db="xxx",
            charset='utf8')

        cursor = db.cursor()
        cursor.execute(sql)
        data = cursor.fetchone()
        db.close()
        return data
