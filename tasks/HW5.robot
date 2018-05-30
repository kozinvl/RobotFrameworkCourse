*** Settings ***
Suite Setup       Login To Remote Host
Suite Teardown    Exit From Remote Host
Force Tags        Global
Default Tags
Test Timeout      2 minutes
Resource          Resource/ResourceHW5.tsv

*** Test Cases ***
Testing UI
    [Tags]    UI    smoke
    [Timeout]    1 minute
    ${res}=    Verify UI
    Run keyword if    '${res}'=='FAILED'    Set Tags    UI ERROR
    ...    ELSE    Set Tags    NO ERROR

Testing Backend
    [Tags]    backend
    Loop Configuration    @{parametrs}

Testing CLI
    [Tags]    CLI
    [Setup]
    RUN
    Created Directory    Robot directory
