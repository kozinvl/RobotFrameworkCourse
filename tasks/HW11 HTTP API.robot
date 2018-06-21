*** Settings ***
Test Setup        Start Session
Test Teardown     Delete All Sessions
Library           RequestsLibrary
Library           Collections

*** Variables ***
${URI}            https://httpbin.org/
${GET}            GET

*** Test Cases ***
HTTP API simple
    ${response}=    Get Request    alias=http    uri=/anything
    ${result_method}=    Get From Dictionary    ${response.json()}    method
    ${result_json}=    Get From Dictionary    ${response.json()}    json
    Should be Equal As Strings    ${result_method}    ${GET}
    Should be Equal As Strings    ${result_json}    ${NULL}
    Delete All Sessions

HTTP API parametrs
    ${response}=    Get Request    alias=http    uri=/anything    params=get?param=text
    ${result_json}=    Get From Dictionary    ${response.json()}    param1
    Delete All Sessions

HTTP API extra headers
    ${headers}    Create Dictionary    Content-Type    application/json    authorisationFlag    N
    ${response}    Get Request    alias=http    uri=/anything    headers=${headers}
    Log    ${response.json()}
    Should be Equal as Strings    ${response.json()['json']}    None
    Delete All Sessions

HTTP API small timeout
    ${response}=    Get Request    alias=http    uri=delay/3    timeout=1

Basic Authorization

*** Keywords ***
Start Session
    Create Session    http    ${URI}    verify=True
