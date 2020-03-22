*** Settings ***
Library           DatabaseLibrary
Library           LBMTest
Library           WsdlTest

*** Variables ***
${server}         {'servername':'kcbp01','protocol':0,'address':'192.168.200.178','port':21000,'sendq':'req_market','recvq':'ans_market','username':'KCXP00','password':'888888'}
${fixpram}        F_FUNCTION:,F_SUBSYS:17,F_OP_USER:8888,F_OP_ROLE:2,F_OP_SITE:127.0.0.1,F_CHANNEL:0,F_SESSION:3k4Ad#@%+^p5x6)==,F_RUNTIME:,F_REMOTE_OP_ORG:,F_REMOTE_OP_USER:,F_OP_ORG:0,
${fixpram_fail}    F_FUNCTION:,F_SUBSYS:17,F_OP_USER:8888,F_OP_ROLE:2,F_OP_SITE:127.0.0.1,F_CHANNEL:0,F_SESSION:3k4Ad#@%+^p5x6)==,F_RUNTIME:,F_REMOTE_OP_ORG:,F_REMOTE_OP_USER:,F_OP_ORG:0,

*** Keywords ***
LoadinitData
    [Documentation]    导入所有用例初始化数据
    ...    入参如下图所示，C:\\Users\\Administrator\\Desktop\\OTC\\otcnewtc_init.sql
    ...    注意sql文件里面，注意“--”需要另起一行，不可以在语句后面加上注释
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Execute Sql Script    ${CURDIR}\\otcnewtc_init.sql
    Disconnect From Database

CheckOperLog
    [Arguments]    ${user_log_sql}    ${user_logdetail_sql}
    [Documentation]    检查是否记录操作日志表和操作日志明细表数据
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Check If Exists In Database    ${user_log_sql}
    Check If Exists In Database    ${user_logdetail_sql}
    Disconnect From Database

UpdateTableData
    [Arguments]    ${UpdateSql}
    [Documentation]    更新数据表数据，一般在测试用例预置数据之前执行
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Execute Sql String    ${UpdateSql}
    Disconnect From Database

DeleteTableData
    [Arguments]    ${DeleteSql}
    [Documentation]    删除数据表数据，一般也是在测试案例预置数据之前执行
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Execute Sql String    ${DeleteSql}
    Disconnect From Database

AddTableData
    [Arguments]    ${InsertSql}
    [Documentation]    插入数据表数据，一般在测试案例预置数据时执行
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Execute Sql String    ${InsertSql}
    Disconnect From Database

CheckTableData
    [Arguments]    ${CheckSql}
    [Documentation]    检查数据库表数据是否正确，所有字段值是否正确，一般在测试案例完成后执行检查
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Check If Exists In Database    ${CheckSql}
    Disconnect From Database

DelAllTableData
    [Arguments]    ${TableName}
    [Documentation]    删除数据表所有数据，根据情况使用该关键字
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Delete All Rows From Table    ${TableName}
    Disconnect From Database

ChecknoTableData
    [Arguments]    ${checknodatasql}
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Check If Not Exists In Database    ${checknodatasql}
    Disconnect From Database

QueryData
    [Arguments]    ${querysql}
    [Documentation]    查询数据库并返回对应的结果集
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    @{queryResults}    Query    ${querysql}
    Disconnect From Database
    [Return]    ${queryResults}

CheckQryData
    [Arguments]    ${querysql}    ${QryNum}
    [Documentation]    检查查询的记录数是否与预期的记录数是否一致
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Row Count Is Equal To X    ${querysql}    ${QryNum}
    Disconnect From Database

LoadTestCaseData
    [Arguments]    ${TestCaseInitData}
    [Documentation]    导入单独测试用例初始化数据
    ...    入参如下图所示，C:\\Users\\Administrator\\Desktop\\OTC\\otcnewtc_init.sql
    ...    注意sql文件里面，注意“--”需要另起一行，不可以在语句后面加上注释
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    Execute Sql Script    ${TestCaseInitData}
    Disconnect From Database

QryCountMum
    [Arguments]    ${querysql}
    [Documentation]    查询数据库并返回对应的结果集
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    ${queryResults}    Row Count    ${querysql}
    Disconnect From Database
    [Return]    ${queryResults}

CreateChkSql
    [Arguments]    ${querysql}
    [Documentation]    自动产生检查语句脚本
    Connect To Database Using Custom Params    pyodbc    "DRIVER={SQL Server};SERVER=127.0.0.1,1433;DATABASE=KSMM_GZ;UID=sa;PWD=sasa"
    create_check_sql    ${querysql}
    Disconnect From Database
