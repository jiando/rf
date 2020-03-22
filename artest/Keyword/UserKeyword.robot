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
    1    2    3    4

baidu
    [Arguments]    ${search_content}
    启动浏览器    http://www.baidu.com
    input text    id=kw    ${search_content}
    click button    id=su
    sleep    2
    ${title}    Get Title
    should contain    ${title}    ${search_content}
    close all browsers
