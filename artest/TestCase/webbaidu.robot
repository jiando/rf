*** Settings ***
Force Tags        suit Force
Default Tags      suit def
Resource          ../Keyword/SystemKeyword.robot
Library           Selenium2Library
Resource          ../Keyword/UserKeyword.robot

*** Test Cases ***
FirstAutoCase
    baidu    artest

baidusearch
    [Tags]    P1
    启动浏览器    http://www.baidu.com
    等待输入成功    input text    //*[@id='kw']    artest
    等待执行成功    click element    //*[@id='su']
    等待页面包含元素    //*[@id="container"]/div[2]/div/div[2]/div
    等待页面标题包含内容    artest
    关闭浏览器
