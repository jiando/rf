*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           XML
Resource          ../Keyword/UserKeyword.robot
Resource          ../Keyword/SystemKeyword.robot

*** Variables ***
${server}         http://47.114.163.52:3000
${api}            /api
${login}          ${api}/user/login
${email}          54437621@qq.com
${password}       123456

*** Test Cases ***
login
    [Tags]    P1
    Create Session    api    ${server}
    &{data}=    Create Dictionary    email=${email}    password=${password}
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${resp}    Post Request    api    ${login}    data=${data}    headers=${headers}
    Comment    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.content}
    Log    ${resp.json()}
    ${responsedata}    To Json    ${resp.content}
    ${keys}    Get Dictionary Keys    ${responsedata}
    ${items}    Get Dictionary Items    ${responsedata}
    ${values}    Get Dictionary Values    ${responsedata}
    ${str}    Get From Dictionary    ${responsedata}    errcode
    Delete All Sessions
