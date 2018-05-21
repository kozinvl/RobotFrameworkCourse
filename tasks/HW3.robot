*** Settings ***
Library           Collections

*** Variables ***
${scalar}         Hi
@{list}           How    are    you?
@{clear list}
&{dictionary}     vasya=1    petya=2

*** Test Cases ***
Scalar variables
    message    ${scalar}
    another message

List variables
    Push your list    @{list}
    Create new list    @{clear list}
    Update your list    @{list}

Dictionary variables
    create and log dictionaries
    update and remove your dict    &{dictionary}
    nested dict?    Yes    &{dictionary}
    Log with navigation

*** Keywords ***
create and log dictionaries
    &{my_keys}    Create Dictionary    1=new    2=old
    Log many    &{my_keys}
    Log many    &{dictionary}

create new list
    [Arguments]    @{clear list}
    @{clear list}=    Create List    I'am    fine
    Log many    @{clear list}

message
    [Arguments]    ${message}
    Log    ${message}    console=true
    ${message}    Set Variable If    "${message}"=="Hi"    ${message} console!
    Log    ${message}    console=true

another message
    ${scalar}    Set Variable    something new
    Variable should Exist    ${scalar}
    Log    ${scalar}    console=true

push your list
    [Arguments]    @{list}
    Log many    @{list}

update your list
    [Arguments]    @{list}
    @{clear list}    Create List    Fine!
    @{combine}    Combine Lists    @{list}    @{clear list}
    Log many    @{combine}

update and remove your dict
    [Arguments]    &{this dict}
    Set To Dictionary    ${this dict}    ivan    3
    Log many    ${this dict}
    Remove From Dictionary    ${this dict}    vasya
    Log many    ${this dict}
    Pop From Dictionary    ${this dict}    ivan
    Log many    ${this dict}

nested dict?
    [Arguments]    ${var}    &{dict}
    Pass Execution If    '${var}' != 'Yes'    Please input 'Yes' in case
    &{nested}=    Create Dictionary    First name=number    added name=${dict}
    Log many    ${nested}

Log with navigation
    Log    ${dictionary.vasya}
    Log    ${dictionary.petya}
    Log many    &{dictionary}[vasya]    &{dictionary}[petya]
