*** Settings ***
Documentation     Test Case #1
...               Connect to database with the prepared parameters in db.conf file.
...               Select from demo1 people with age < 7. Implement it as a custom keyword.
...               Test fail if salary > 0
...               Disconnect from database
...               Test Case #2
...               Connect to database with using all parameters
...               Delete all information from table demo1
...               Calculate count of rows in the table
...               Test fail if count of rows > 0.
...               Disconnect from database
...               Test Case #3
...               Connect to database with using custom parameters
...               Use Execute Sql Script to add ten records to demo1. Implement it as a custom keyword.
...               Calculate count of records.
...               Test fail if count of records <> 10.
...               Disconnect from database
Library           DatabaseLibrary

*** Variables ***
${IP}             192.000.000.00
${PORT}           3306
${sql_script}     /Users/vkozin/Downloads/newhome/HW/Resource/sql.txt
${config}         c:\\db.cfg
${DB}             pymysql

*** Test Cases ***
Prepared parametrs
    Connect to Database    dbConfigFile=${config}
    ${result}=    Select Salary from DB
    Should be Empty    ${result}
    Disconnect From Database

Using all parametrs
    Connect to Database    ${DB}    vkozin    vkozin    vkozinpass    ${IP}    ${PORT}
    Delete all Rows From Table    demo1
    Row Count is 0    select * from demo1
    Disconnect From Database

Custom parameters
    Connect To Database Using Custom Params    ${DB}    database='vkozin',user='vkozin', password='vkozinpass', host='${IP}',port=${PORT}
    Add records
    Row Count Is Equal To X    Select * from demo1    10
    Disconnect From Database

*** Keywords ***
Select Salary from DB
    ${select}    Query    SELECT salary FROM demo1 WHERE Age < 7 AND Salary > 0
    [Return]    ${select}

Add Records
    Execute SQL Script    ${sql_script}
    ${res}    Query    Select * from demo1
