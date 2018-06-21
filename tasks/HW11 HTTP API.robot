*** Settings ***
Test Teardown     Delete All Sessions
Library           RequestsLibrary
Library           Collections

*** Variables ***
${URI}            https://httpbin.org
${GET}            GET

*** Test Cases ***
HTTP API simple
    Start Session
    ${response}=    Get Request    alias=http    uri=/anything
    ${result_method}=    Get From Dictionary    ${response.json()}    method
    ${result_json}=    Get From Dictionary    ${response.json()}    json
    Should be Equal As Strings    ${result_method}    ${GET}
    Should be Equal As Strings    ${result_json}    ${NULL}

HTTP API parametrs
    Start Session
    ${params}    Create Dictionary    param    text
    ${response}=    Get Request    http    /get    params=${params}
    ${jsondata}=    To Json    ${response.content}
    Should Be Equal    ${jsondata['args']}    ${params}

HTTP API extra headers
    Start Session
    ${headers}    Create Dictionary    Content-Type    application/json    authorisationFlag    N
    ${response}    Get Request    alias=http    uri=/anything    headers=${headers}
    Log    ${response.json()}
    Should be Equal as Strings    ${response.json()['json']}    None

HTTP API small timeout
    Start Session
    ${response}=    Get Request    alias=http    uri=delay/3    timeout=1

Basic Authorization
    ${auth}=    Create List    student    111
    Start Session    ${auth}
    ${resp}=    Get Request    http    /basic-auth/student/111
    Should Be Equal As Strings    ${resp.json()['authenticated']}    True
    Should Be Equal As Strings    ${resp.json()['user']}    student

*** Keywords ***
Start Session
    [Arguments]    ${auth}=None
    Create Session    http    ${URI}    auth=${auth}    verify=True
