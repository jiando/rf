*** Settings ***
Resource          action.txt
Library           RequestsLibrary

*** Test Cases ***
validlogin
    login    admin    admin    退出

Invalid username
    login    admin123    admin    帐号或密码错误！

Invalid password
    login    admin    admin123    帐号或密码错误！

Invalid both
    login    admin1    admin13    帐号或密码错误！

visithome
    Create Session    home    http://47.114.163.52:3000
    ${addr}    Get request    home    /smeoa/index.php?m=login&a=index
    should be equal as strings    ${addr.status_code}    200

*** Keywords ***
login
    [Arguments]    ${username}    ${password}    ${expect}
    ${headers}    create dictionary    Content-Type=application/x-www-form-urlencoded
    ${param}    create dictionary    emp_no=${username}    password=${password}
    create session    api    http://47.114.163.52:3000
    ${addr}    post request    api    /user/login    data=${param}    headers=${headers}
    should be equal as strings    ${addr.status_code}    200
    ${content}    set variable    ${addr.content.decode('utf-8')}
    should contain    ${content}    ${expect}
