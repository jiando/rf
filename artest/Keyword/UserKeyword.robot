*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Library           Collections

*** Keywords ***
xunhuan
    [Arguments]    ${number}
    FOR    ${i}    IN RANGE    ${number}
        LOG    ${i}
    END

yplogin
    [Arguments]    ${email}    ${password}
    [Documentation]    ${email} | ${password}
    54437621@qq.com    123456

liebiao
    [Arguments]    ${canshu1}    ${canshu2}    ${canshu3}    ${canshu4}=1111

baidu
    [Arguments]    ${search_content}
    启动浏览器    http://www.baidu.com
    input text    id=kw    ${search_content}
    click button    id=su
    sleep    2
    ${title}    Get Title
    should contain    ${title}    ${search_content}
    close all browsers

启动浏览器
    [Arguments]    ${url}
    open browser    ${url}    chrome
    maximize browser window

等待执行成功
    [Arguments]    ${keyword}    ${locator}
    Wait Until Keyword Succeeds    1 min    0.1 sec    ${keyword}    ${locator}

等待输入成功
    [Arguments]    ${keyword}    ${locator}    ${text}
    Wait Until Keyword Succeeds    1 min    0.1 sec    ${keyword}    ${locator}    ${text}

等待页面包含元素
    [Arguments]    ${locator}    ${timeout}=2    ${error}="页面没有获取到${locator}"
    Wait Until Page Contains Element    ${locator}    ${timeout}    ${error}

等待页面标题包含内容
    [Arguments]    ${search_content}
    sleep    2
    ${title}    Get Title
    should contain    ${title}    ${search_content}

关闭浏览器
    close browser
