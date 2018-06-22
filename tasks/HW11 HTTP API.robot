*** Settings ***
Test Teardown     Delete All Sessions
Library           RequestsLibrary
Library           Collections

*** Variables ***
${URI}            https://httpbin.org
${GET}            GET
${none}           None

*** Test Cases ***
HTTP API simple
    Start Session
    ${response}=    Get Request    http    /anything
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
    ${headers}    Create Dictionary    Content-Type=application/json; charset=utf-8
    ${response}    Get Request    http    uri=/get    headers=${headers}
    Log    ${response.json()}
    Should be Equal as Strings    ${response.json()['headers']['Content-Type']}    application/json; charset=utf-8

HTTP API small timeout
    Start Session
    ${response}=    Get Request    http    /delay    timeout=1
    Should Be Equal As Strings    ${response.status_code}    404

HTTP Basic Authorization
    ${auth}=    Create List    student    111
    Start Session    ${auth}
    ${resp}=    Get Request    http    /basic-auth/student/111
    Should Be Equal As Strings    ${resp.json()['authenticated']}    True
    Should Be Equal As Strings    ${resp.json()['user']}    student

HTTP API delete request
    Create Session    http    ${URI}
    ${response}=    Delete Request    http    /delete
    Should Be Equal As Strings    ${response.status_code}    200

HTTP API post request
    Start Session
    ${str}=    Set Variable    {"x":"y"}
    ${json_data}=    To Json    ${str}
    ${response}=    Post request    http    /post    json=${json_data}
    Should Be Equal as Strings    ${response.json()['data']}    json=${json_data}

*** Keywords ***
Start Session
    [Arguments]    ${arg}=${none}
    Create Session    http    ${URI}    auth=${arg}    verify=True
