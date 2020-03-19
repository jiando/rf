*** Settings ***
Force Tags        suit Force
Default Tags      suit def
Resource          ../Keyword/UserKeyword.robot
Library           Selenium2Library

*** Test Cases ***
login
    [Template]
    启动浏览器    http://47.114.163.52:3000
    等待执行成功    click element    //*[@id="yapi"]/div/div[1]/div/div/div[1]/div[2]/div/div[2]/div[1]/div/div[3]/a/button
    等待输入成功    input text    //*[@id="email"]    54437621@qq.com
    等待输入成功    input text    //*[@id="password"]    123456
    等待执行成功    click element    //*[@id="yapi"]/div/div[1]/div/div/div[2]/div/div/div/div/div/div[2]/div[2]/div[1]/form/div[3]/div/div/span/button
    等待页面包含元素    //*[@id="yapi"]/div/div[1]/div[2]/div/div/div/div[2]/div/div/div[1]/div/div/div/div/div[2]
    关闭浏览器

*** Keywords ***
loginaccount
    #用户名    #密码    #结果
    54437621@qq.com    123456    登录成功
    54437621    123456    账号不存在
    54437621@qq.com    \    请输入密码
            请输入内容
