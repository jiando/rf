*** Settings ***
Library           OperatingSystem

*** Test Cases ***
test
    import library    D:/github/rf/har/run.py -f "C:/Users/Administrator/Desktop/192.168.1.9.har" -o "C:/Users/Administrator/Desktop/1.txt" -e 2096147163@qq.com -p qwer123456789

2
    RUN    cd D:
    RUN    cd github/rf/har/
    RUN    run.py -f "C:/Users/Administrator/Desktop/192.168.1.9.har" -o "C:/Users/Administrator/Desktop/1.txt" -e 2096147163@qq.com -p qwer123456789
