*** Settings ***
Force Tags        suit Force
Default Tags      suit def
Resource          ../Keyword/UserKeyword.robot
Library           Selenium2Library
Resource          ../Keyword/SystemKeyword.robot

*** Test Cases ***
login
    [Template]    logintest
    #用户名    #密码    #预期结果
    54437621@qq.com    123456    //*[@id="yapi"]/div/div[1]/div[2]/div/div/div/div[2]/div/div/div[2]/div[1]/div/div[1]/div[2]/a/button
    54437621    123456    //*[@id="yapi"]/div/div[1]/div/div/div[2]/div/div/div/div/div/div[2]/div[2]/div[1]/form/div[3]/div/div/span/button
    54437621@qq.com    12345    //*[@id="yapi"]/div/div[1]/div/div/div[2]/div/div/div/div/div/div[2]/div[2]/div[1]/form/div[3]/div/div/span/button

*** Keywords ***
logintest
    [Arguments]    ${email}    ${password}    ${expect}
    启动浏览器    http://47.114.163.52:3000
    等待执行成功    click element    //*[@id="yapi"]/div/div[1]/div/div/div[1]/div[2]/div/div[2]/div[1]/div/div[3]/a/button
    等待输入成功    input text    //*[@id="email"]    ${email}
    等待输入成功    input text    //*[@id="password"]    ${password}
    等待执行成功    click element    //*[@id="yapi"]/div/div[1]/div/div/div[2]/div/div/div/div/div/div[2]/div[2]/div[1]/form/div[3]/div/div/span/button
    等待页面包含元素    ${expect}
    关闭浏览器
