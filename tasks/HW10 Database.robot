*** Settings ***
Library           DatabaseLibrary

*** Test Cases ***
Prepared parametrs
    Connect to Database    ${EXECDIR}/Resource/db.cfg
    ${result}    Select Salary from DB

Using all parametrs
    Connect to Database    pymysql    db1    vkozin    159753852

Custom parameters
    Connect To Database Using Custom Params

*** Keywords ***
Select Salary from DB
