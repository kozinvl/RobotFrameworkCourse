*** Settings ***
Suite Setup
Test Setup
Library           SSHLibrary

*** Variables ***
${IP}             192.000.000.00
${PASSWORD}       159753852
${USER_NAME}      vkozin
${PRIVATE KEY}    /Users/vkozin/.ssh/id_rsa

*** Test Cases ***
Remote Server
    Open Connection    ${IP}    alias=first_connection
    Login    ${USER_NAME}    ${PASSWORD}
    Write Some Text
    File Should Exist    /tmp/demo.txt
    Get File    /tmp/demo.txt    ${CURDIR}/tmp/
    Remote Connection with SSH key
    Switch Connection    first_connection
    Execute Command    rm -f /tmp/demo.txt\n
    Switch Connection    second_connection
    File Should Not Exist    /tmp/demo.txt
    Close All Connections

*** Keywords ***
Remote Connection with SSH key
    Open Connection    ${IP}    alias=second_connection
    Login with Public Key    ${USER_NAME}    ${PRIVATE KEY}
    Write Some Text
    Execute command    cat demo.txt
    ${output}    Read Until    this is text

Write Some Text
    Write until expected output    cat>/tmp/demo.txt\n    \    timeout=5s    retry_interval=2s
    Write    this is text
