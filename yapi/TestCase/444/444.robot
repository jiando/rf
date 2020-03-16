*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           XML

*** Test Cases ***
case1
    Create Session    api    http://localhost:8000
    ${addr}    Get Request    api    users/1
    Should Be Equal As Strings    ${addr.status_code}    200
    Log    ${addr.content}
    ${responsedata}    To Json    ${addr.content}
    ${keys}    Get Dictionary Keys    ${responsedata}
    ${items}    Get Dictionary Items    ${responsedata}
    ${values}    Get Dictionary Values    ${responsedata}
    ${str}    Get From Dictionary    ${responsedata}    1
    ${addr}    Get Request    api    users/5
    Should Be Equal As Strings    ${addr.status_code}    404
    Log    ${addr.content}
    ${responsedata}    To Json    ${addr.content}
    ${keys}    Get Dictionary Keys    ${responsedata}
    ${items}    Get Dictionary Items    ${responsedata}
    ${values}    Get Dictionary Values    ${responsedata}
    ${str}    Get From Dictionary    ${responsedata}    message
    Delete All Sessions

case2
    Create Session    api    http://localhost:8000
    ${addr}    Get Request    api    hello/qitao
    Comment    Should Be Equal As Strings    ${addr.status_code}    200
    Log    ${addr.content}
    ${responsedata}    To Json    ${addr.content}
    ${keys}    Get Dictionary Keys    ${responsedata}
    ${items}    Get Dictionary Items    ${responsedata}
    ${values}    Get Dictionary Values    ${responsedata}
    ${str}    Get From Dictionary    ${responsedata}    hello
    #xml方式
    ${dict}    Create Dictionary    accept=application/xml
    ${addr}    Get Request    api    hello/qitao    ${dict}
    Comment    Should Be Equal As Strings    ${addr.status_code}    200
    Log    ${addr.content}
    ${responsedata}    Set Variable    ${addr.content}
    ${body}    Get Element Text    ${responsedata}    hello
    ${hello}    Get Element    ${responsedata}    hello
    Log    ${hello.text}
    ${responsedata}    Add Element    ${responsedata}    <new id="3">test</new>
    ${new}    Get Element Attribute    ${responsedata}    id    new
    Log    ${new}
    ${a}    Element To String    ${responsedata}
    Delete All Sessions

case3
    #用户密码
    ${auth}    Create List    ok    python
    Create Session    api    http://localhost:8000    \    \    ${auth}
    ${addr}    Get Request    api    401
    Comment    Should Be Equal As Strings    ${addr.status_code}    200
    Log    ${addr.content}
    ${responsedata}    To Json    ${addr.content}
    ${keys}    Get Dictionary Keys    ${responsedata}
    ${items}    Get Dictionary Items    ${responsedata}
    ${values}    Get Dictionary Values    ${responsedata}
    ${str}    Get From Dictionary    ${responsedata}    pass
    Delete All Sessions

case4
    Create Session    api    http://47.114.163.52:3000
    &{data}=    Create Dictionary    email=54437621@qq.com    password=123456
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${addr}    Post Request    api    /api/user/login    data=${data}    headers=${headers}
    Comment    Should Be Equal As Strings    ${addr.status_code}    200
    Log    ${addr.content}
    Log    ${addr.json()}
    ${responsedata}    To Json    ${addr.content}
    ${keys}    Get Dictionary Keys    ${responsedata}
    ${items}    Get Dictionary Items    ${responsedata}
    ${values}    Get Dictionary Values    ${responsedata}
    ${str}    Get From Dictionary    ${responsedata}    errcode
    Delete All Sessions