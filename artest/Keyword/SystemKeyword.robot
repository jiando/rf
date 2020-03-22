*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Library           Collections

*** Keywords ***
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
    sleep    1

等待页面标题包含内容
    [Arguments]    ${search_content}
    sleep    2
    ${title}    Get Title
    should contain    ${title}    ${search_content}

关闭浏览器
    close browser

元素是否存在
    [Arguments]    ${locator}
    Element Should Be Enabled    ${locator}
