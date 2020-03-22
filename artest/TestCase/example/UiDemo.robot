*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Library           Collections
Variables         ProUI.py
Library           path.py

*** Variables ***
${identify_code}    11    #验证码

*** Keywords ***
启动浏览器
    [Arguments]    ${url}
    open browser    ${url}    chrome
    maximize browser window

登录
    [Arguments]    ${username}    ${password}    ${name}
    ${username}    Decrypt    ${username}
    ${password}    Decrypt    ${password}
    等待输入成功    input text    //*[@id='usename']    ${username}    #登录名
    等待执行成功    click element    //div/div[3]/form[1]/div/ul/li[2]/input    #触发机制
    等待输入成功    input text    //div/div[3]/form[1]/div/ul/li[2]/input    ${password}
    等待执行成功    click element    //*[@id='provinceCode']    #省分
    等待执行成功    click element    //a[text()='${name}']    #天津
    Sleep    5    #输入验证码
    等待执行成功    click element    //*[@id='btn-login']    #登录

关闭浏览器
    close browser

点击元素
    [Arguments]    ${Xpath}
    Wait Until Element Is Visible    ${Xpath}
    click element    ${Xpath}

一级菜单
    [Arguments]    ${name}
    Wait Until Element Is Visible    //a[text()='${name}']
    click element    //a[text()='${name}']
    sleep    2

二三级菜单
    [Arguments]    ${name}
    Wait Until Element Is Visible    //span[text()='${name}']
    click element    //span[text()='${name}']
    sleep    3

等待页面包含元素
    [Arguments]    ${locator}    ${timeout}=10    ${error}="页面没有获取到${locator}"
    Wait Until Page Contains Element    ${locator}    ${timeout}    ${error}

等待页面不包含元素
    [Arguments]    ${locator}    ${timeout}=10    ${error}="页面包含${locator}"
    Wait Until Page Does Not Contain Element    ${locator}    ${timeout}    ${error}

元素应该不可见
    [Arguments]    ${locator}    ${msg}="该${locator}不可见"
    Element Should Not Be Visible    ${locator}    ${msg}

等待元素不可见
    [Arguments]    ${locator}    ${timeout}=10    ${error}="该${locator}可见"
    Wait Until Element Is Not Visible    ${locator}    ${timeout}    ${error}

等待元素可用
    [Arguments]    ${locator}    ${timeout}=10    ${error}="该${locator}不可用"
    Wait Until Element Is Enabled    ${locator}    ${timeout}    ${error}

等待元素可见
    [Arguments]    ${locator}
    sleep    2
    Wait Until Element Is Visible    ${locator}    20 sec

等待执行成功
    [Arguments]    ${keyword}    ${locator}
    Wait Until Keyword Succeeds    1 min    0.1 sec    ${keyword}    ${locator}

等待输入成功
    [Arguments]    ${keyword}    ${locator}    ${text}
    Wait Until Keyword Succeeds    1 min    0.1 sec    ${keyword}    ${locator}    ${text}

点击拖动条
    [Arguments]    ${name}
    Scroll Element Into View    //span[text()='${name}']
    sleep    1

选择iframe
    [Arguments]    ${locator}
    Select Frame    ${locator}

取消选择iframe
    Unselect Frame

根据Value从List选择
    [Arguments]    ${locator}    @{values}
    Select From List By Value    ${locator}    @{values}

根据Label从List选择
    [Arguments]    ${locator}    @{labels}
    Select From List By Label    ${locator}    @{labels}

上传文件
    [Arguments]    ${locator}    ${filepath}
    ${Upfile}    Upfiletoabsolthpath    ${filepath}
    等待输入成功    Choose File    ${locator}    ${Upfile}

捕获页面文本
    Wait Until Page Contains    txt

常江专用根据Lable从List选择
    [Arguments]    ${locator}    @{labels}
    Wait Until Keyword Succeeds    1 min    0.1 sec    Select From List By Label    ${locator}    @{labels}

常江专用等待未出现重新打开页面
    [Arguments]    ${link}    ${element}
    FOR    ${num}    IN RANGE    5
    Set_Browser_Implicit_Wait    10    #隐式等待
    ${Not_Contain}    Run_keyword_and_return_status    Page Should Not Contain Element    xpath=${element}    #判断界面元素是否出现
    Run_keyword_if    '${Not_Contain}'=='True'    Click Element    xpath=${link}    #如没有包含元素，则重新点击元素,例如定价管理二级菜单
    Run_keyword_if    '${Not_Contain}'=='False'    Exit_for_loop    #实际上,这里默认会解绑iframe,如果前面有iframe嵌套,请重新指定iframe!

等待页面响应
    sleep    3

清除输入框内容
    [Arguments]    ${locator}    ${count}
    FOR    ${i}    IN RANGE    ${count}
    Press Key    ${locator}    \\8

二三级菜单（js）
    [Arguments]    ${name}
    sleep    2
    Execute Javascript    $("span:contains('${name}')").click()
    sleep    2

连接数据库
    [Arguments]    ${sql_url}
    ${sql_url}    Decrypt    ${sql_url}
    Connect To Database Using Custom Params    pymysql    ${sql_url}

判断输入框是否为空
    [Arguments]    @{arg}
    sleep    3
    FOR    ${element}    IN    @{arg}
    ${zhi}    Get Value    ${element}
    log    ${zhi}
    Should Be Empty    ${zhi}
