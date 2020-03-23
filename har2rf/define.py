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

DATA = {'case_steps': [{"comment": [],
                        "args": '',
                        "assign": ["${response}"],
                        "keyword": "req",
                        'type': False},
                       {"comment": [],
                        "args": ["200",
                                 "${response.status_code}"],
                        "assign": [],
                        "keyword": "Should Be Equal As Strings",
                        'type': False}],
        'name': None}
