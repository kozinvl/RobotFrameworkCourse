*** Settings ***
Library           Libraries/SystemActions.py    ${EXECDIR}
Library           Libraries/StaticLibrary.py

*** Variables ***
${MD5}            cfcd208495d565ef66e7dff9f98764da

*** Test Cases ***
Check notepad in directory without class
    @{files}=    StaticLibrary.Get Files Directory    ${EXECDIR}
    ${result}=    StaticLibrary.Check Contain    ${files}    notepad.exe
    Should be True    ${result}
    ${md5_result}=    StaticLibrary.Get Md5 Sum ${EXECDIR}/notepad.exe
    Should be Equal as Strings    ${md5_result}    ${MD5}

Check notepad in directory with class
    @{files}=    SystemActions.Get Files Directory
    ${result}=    SystemActions.Check Contain    ${files}    notepad.exe
    Should be True    ${result}
    ${md5_result}=    Calculate MD5 notepad.exe
    Should be Equal as Strings    ${md5_result}    ${MD5}

