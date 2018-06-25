*** Settings ***
Library           OperatingSystem
Library           Libraries/StaticLibrary.py
Library           Libraries/StaticLibrary2.py

*** Variables ***
${MD5}            cfcd208495d565ef66e7dff9f98764da

*** Test Cases ***
Check notepad in directory
    @{files}=    Get Files Directory    ${EXECDIR}
    ${result}=    Check Contain    ${files}    notepad.exe
    Should be True    ${result}
    ${md5_result}=    Get MD5 Sum    ${EXECDIR}/notepad.exe
    Should be Equal as Strings    ${md5_result}    ${MD5}

Check notepad in directory
    @{files}=    Get Files Directory    ${EXECDIR}
    ${result}=    Check Contain    ${files}    notepad.exe
    Should be True    ${result}
    ${md5_result}=    Get MD5 Sum    ${EXECDIR}/notepad.exe
    Should be Equal as Strings    ${md5_result}    ${MD5}
