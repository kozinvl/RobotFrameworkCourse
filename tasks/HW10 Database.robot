*** Settings ***
Library           DatabaseLibrary

*** Test Cases ***
Prepared parametrs
    Connect to Database    dbConfigFile=${EXECDIR}/Resource/db.cfg
    ${result}    Select Salary from DB
    Disconnect From Database

Using all parametrs
    Connect to Database    pymysql    db1    vkozin    159753852

Custom parameters
    Connect To Database Using Custom Params

*** Keywords ***
Select Salary from DB
    Query    SELECT people FROM vkozin WHERE Age < 7
