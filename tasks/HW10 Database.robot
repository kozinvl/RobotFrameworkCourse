*** Settings ***
Library           DatabaseLibrary

*** Variables ***
${IP}             192.168.242.44
${PORT}           3306
${sql_script}     /Users/vkozin/Downloads/newhome/HW/Resource/sql.txt
${path}           ${EXECDIR}/Resource/db.cfg
${DB}             pymysql

*** Test Cases ***
Prepared parametrs
    Connect to Database    default=/db.cfg
    ${result}    Select Salary from DB
    Disconnect From Database

Using all parametrs
    Connect to Database    ${DB}    vkozin    vkozin    vkozinpass    ${IP}    ${PORT}
    ${res}    Select Salary from DB
    #Delete all Rows From Table    demo1
    #Row Count is 0    select * from demo1
    #Disconnect From Database

Custom parameters
    Connect To Database Using Custom Params    ${DB}    database='vkozin',user='vkozin', password='vkozinpass', host='${IP}',port=${PORT}
    Add records
    Row Count Is Equal To X    Select * from demo1    10
    Disconnect From Database

*** Keywords ***
Select Salary from DB
    Query    SELECT salary FROM demo1 WHERE Age < 7 AND Salary > 0

Add Records
    Execute SQL Script    ${sql_script}
    ${res}    Query    Select * from demo1
