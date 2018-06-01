*** Settings ***
Force Tags        s1

*** Test Cases ***
Case1
    [Tags]    c1
    Log    Hi console    console=true
    Should be equal    5    5.1

Case2
    [Tags]    c2
    Log    Hi console    console=true
