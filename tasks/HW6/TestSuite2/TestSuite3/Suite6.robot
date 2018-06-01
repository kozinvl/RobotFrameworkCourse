*** Settings ***
Force Tags        s6

*** Test Cases ***
Case11
    [Tags]    c11
    Log    Hi console    console=true

Case12
    [Tags]    c12
    Log    Hi console    console=true
