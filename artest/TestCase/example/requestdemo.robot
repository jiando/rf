*** Settings ***
Library           Collections
Library           String
Library           RequestsLibrary
Library           OperatingSystem

*** Test Cases ***
最简单的get
    [Tags]    get
    Create Session    getdemo    http://httpbin.org
    ${resp}=    Get Request    getdemo    /get
    log    ${resp.status_code}
    log    ${resp.content}
    log    ${resp.headers['content-length']}
    Delete All Sessions

带参数的get
    Create Session    getdemo    http://httpbin.org
    ${response}    Get Request    getdemo    /get?key=rftest
    log    ${response.text}
    Delete All Sessions

带参数的get2
    Create Session    getdemo    http://httpbin.org
    ${param}    Create Dictionary    key    rftest
    ${response}    Get Request    getdemo    /get    ${param}
    log    ${response.text}
    Delete All Sessions

修改headers的get
    Create Session    getdemo    http://httpbin.org
    ${param}    Create Dictionary    key    rftest
    ${headers}    Create Dictionary    User-Agent    aaaaaaaaaaaa
    ${response}    Get Request    getdemo    /get    ${headers}
    log    ${response.text}
    Delete All Sessions

重定向的get
    http://httpbin.org/redirect/1
    Create Session    getdemo    http://httpbin.org
    ${response}    Get Request    getdemo    /redirect/1    allow_redirects=${False}
    log    ${response.text}
    Delete All Sessions

POST 到data
    Create Session    postdemo    http://httpbin.org
    ${data}    Create Dictionary    a    1    b    2
    ${response}    Post Request    postdemo    /post    ${data}
    log    ${response.text}
    Delete All Sessions

POST 到form
    Create Session    postdemo    http://httpbin.org
    ${data}    Create Dictionary    a    1    b    度假村
    ${headers}=    Create Dictionary    Content-Type    application/x-www-form-urlencoded
    ${response}    Post Request    postdemo    /post    ${data}    ${headers}
    log    ${response.json()['form']['b']}
    Delete All Sessions

POST到files
    Create Session    postdemo    http://httpbin.org
    ${file_data}=    Get Binary File    D:\\aaaa.txt
    ${files}=    Create Dictionary    file    ${file_data}
    ${resp}=    Post Request    postdemo    /post    files=${files}
    log    ${resp.text}

PUT、DELETE 和post一样

Auth的例子
    ${auth}=    Create List    user    passwd
    Create Session    httpbin    http://httpbin.org    auth=${auth}
    ${resp}=    Get    httpbin    /basic-auth/user/passwd
    Should Be Equal As Strings    ${resp.status_code}    200
    log    ${resp.text}
