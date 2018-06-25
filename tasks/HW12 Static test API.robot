*** Settings ***
Library           OperatingSystem
Library           Libraries/SystemActions.py    ${EXECDIR}

*** Variables ***
${MD5}            cfcd208495d565ef66e7dff9f98764da

*** Test Cases ***
Check notepad in directory
    @{files}=    Get Files Directory    ${EXECDIR}
    ${result}=    Check Contain    ${files}    notepad.exe
    Should be True    ${result}
    ${md5_result}=    Get MD5 Sum    ${EXECDIR}/notepad.exe
    Should be Equal as Strings    ${md5_result}    ${MD5}

Check notepad in directory2
    @{files}=    SystemActions.Get_files_directory
    ${result}=    SystemActions.Check Contain    ${files}    notepad.exe
    Should be True    ${result}
    ${md5_result}=    SystemActions.Get MD5 Sum    ${EXECDIR}/notepad.exe
    Should be Equal as Strings    ${md5_result}    ${MD5}
