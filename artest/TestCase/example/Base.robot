*** Settings ***
Resource          ../../Keyword/UserKeyword.robot

*** Variables ***
${hi}             Robot Framework

*** Test Cases ***
if
    ${a}    set variable    55
    run keyword if    ${a}>=90    log    you
    ...    ELSE IF    ${a}<=70    log    lang
    ...    ELSE IF    ${a}<=60    log    jige
    ...    ELSE    log    bujige

log
    log    xiao ${hi}

for
    xunhuan    5

list
    liebiao    1    2    3

temp
    [Template]    log
    张三
    李四
    王五
