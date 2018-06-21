*** Settings ***
Documentation     You should have access to any remote server with login/password and public key.
...               Test case #1:
...               Open connection to remote server.
...               Login with login/password.
...               Change directory to /tmp.
...               Create a file "demo.txt" with text: "this is a text file".
...               Run "ls" command.
...               Check that the file "demo.txt" is present.
...               Upload this file to the local PC.
...               Open new connection to the same server.
...               Login with public key to remote server.
...               Use Write keyword: "cat /tmp/demo.txt".
...               Use Read Until, to check content of "demo.txt" file.
...               Switch connection to the first one.
...               Delete "demo.file".
...               Switch connection to the second one.
...               Check that this file is absent.
...               Close all connections.
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
    Execute Command    rm -f /tmp/demo.txt
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
    Write until expected output    cat>/tmp/demo.txt    \    timeout=5s    retry_interval=2s
    Write    this is text
