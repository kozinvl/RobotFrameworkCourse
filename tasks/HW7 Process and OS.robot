*** Settings ***
Documentation     Precondition:
...               You have to logged in to Linux/MacOS host.
...               Test case #1:
...               Go to home directory.
...               Create python source code file.
...               Make it executable.
...               Run it.
...               Check results.
...               Run it again and store stdout to a file.
...               Grep results from the file.
...               Check results.
...               Copy this file to /tmp directory
...               Create a directory with name src in the home directory.
...               Move python file there.
...               List directory and log results.
...               Test case #2:
...               Go to /var/log directory. (Note: the path can be differ in your environment)
...               Try to find "ERROR" string in the "messages" file with help foreground keyword. (you can use other big log file in your OS)
...               Analyze the result object.
...               Run cat /var/log/messages in background.
...               Wait the process 0.1s on timeout terminate the process.
...               Check the result object.
Library           OperatingSystem
Library           Process

*** Variables ***
${path_logs}      ~/Library/Logs/
${path_logs_diagnostic}    ~/Library/Logs/DiagnosticReports
${path}           /Users/vkozin/Library/Logs/DiagnosticReports

*** Test Cases ***
Case1
    Create File    ${EXECDIR}/Libraries/source.py    def hi(): print('hi')    encoding=UTF-8
    ${result}=    Run process    python    ${EXECDIR}/Libraries/source.py
    Should be Equal as Integers    ${result.rc}    0
    ${std_result}=    Run process    python    ${EXECDIR}/Libraries/source.py
    Create File    ${EXECDIR}/output.txt    ${std_result.rc}\    encoding=UTF-8
    ${grep_result}    Grep File    ${EXECDIR}/output.txt    *
    Should be Equal as Integers    ${grep_result}    ${std_result.rc}
    Copy File    ${EXECDIR}/output.txt    ${EXECDIR}/tmp/
    Create Directory    ${EXECDIR}/src/
    Move File    ${EXECDIR}/Libraries/source.py    ${EXECDIR}/src/
    @{list_items}    List Directory    ${EXECDIR}
    Log many    @{list_items}    console=true

Case2
    ${Grep Result}=    Grep File    ${path_logs_diagnostic}/log.crash    Error
    Should contain    ${Grep Result}    Error
    ${process background}    Start process    sudo ${path_logs_diagnostic}/log.crash    shell=true    alias=process
    ${res}    Wait For Process    process    timeout=0.1s    on_timeout=kill
    Should Be Equal as integers    ${res.rc}    1
