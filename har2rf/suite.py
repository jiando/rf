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


class Save(object):

    def __init__(self, path):
        self.path = path

    def new_suite(self):
        with open(self.path, mode='wb+') as f:
            f.write(bytes('*** Settings ***\n*** Test Cases ***\n', 'UTF-8'))

    @staticmethod
    def suite_save(file_data, test_data):
        imports = [{'type': 'Library', 'name': 'CustomLibrary'},
                   {'type': 'Library', 'name': 'YamlLibrary'}]

        test_data = test_data

        test_data.setting_table.imports.data = []
        for each_import in imports:
            if each_import["type"] == "Library":
                test_data.setting_table.add_library(each_import["name"])
            if each_import["type"] == "Resource":
                test_data.setting_table.add_resource(each_import["name"])
            if each_import["type"] == "variable":
                test_data.setting_table.add_resource(each_import["name"])

        case_object = test_data.testcase_table.add(file_data['name'])
        case_steps = file_data["case_steps"]
        if case_steps:
            case_object.steps = []
            for each_step in case_steps:
                row_list = []
                type = each_step.get('type', '')
                if not type:
                    assign = each_step.get("assign", [])
                    keyword = each_step.get("keyword", "")
                    comment = each_step.get("comment", [])
                    args = each_step.get("args", [])
                    if assign:
                        for each_assign in assign:
                            row_list.append(each_assign)
                    if keyword:
                        row_list.append(keyword)
                    if args:
                        for each_args in args:
                            row_list.append(each_args)
                    if comment:
                        for each_comment in comment:
                            row_list.append(each_comment)
                    case_object.add_step(row_list)

        test_data.save(format="txt")
