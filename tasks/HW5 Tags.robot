*** Settings ***
Documentation     There is a remote host (RH)
...               There is a web server and backend server there.
...
...               Our goal is connect to RH and perform three verifications.
...               Each verification is one test case. So you need to create a test suite with three test cases.
...               The first test cases is testing UI.
...               The second test cases is testing backend.
...               The third test case is testing CLI.
...
...               For testing needs we have special library:
...               1. "Verify UI". No params. Returns FAILED.
...               2. "Verify backend". No params. Returns PASSED.
...               3. "Edit Config". Param 1: string param=value. Example: host=www.hostname.ua
...               4. "Backup Configuration" - store configuration file. No params.
...               5. "Restore Configuration" - restore configuration file. No params.
...               6. "Run". Param 1: cli command. Example: dir \ (output directory content in Windows)
...               7. "Login To Remote Host". No params.
...               8. "Exit From Remote Host". No params.
...
...               The test suite has mandatory tag 'Global'
...
...               The first test case has tags 'UI' and 'smoke'. Timeout - one minute.
...               It runs UI verification and check result.
...               If result is failed, then set new tag - 'UI_Error', else set tag 'No_Errors'.
...
...               The second test case has tag 'backend'.
...               You should edit configuration file and update three params in it 'host', 'username' and 'password'. \ Use loop for it.
...               Explanation: configuration file has structure: param1=value1, new line param2=value2, etc.
...               Be careful! You should think that each test case can be run independently of other tests cases.
...               Think about how to avoid corruption of a configuration file to run other tests.
...               Unless backend verification returns PASSED then set tag to 'Backend_Error'.
...
...               The third test case has tag 'CLI'.
...               You have to create five directories in current directory with name robot_${index} where ${index} in 1..5.
...               You have to clean created directories after test case finished.
...
...
...               Please run all test cases independently by tags.
Suite Setup       Login To Remote Host
Suite Teardown    Exit From Remote Host
Force Tags        Global
Default Tags
Test Timeout      2 minutes
Resource          Resource/ResourceHW5.tsv

*** Test Cases ***
Testing UI
    [Tags]    UI    smoke
    [Timeout]    1 minute
    ${res}=    Verify UI
    Run keyword if    '${res}'=='FAILED'    Set Tags    UI ERROR
    ...    ELSE    Set Tags    NO ERROR

Testing Backend
    [Tags]    backend
    Loop Configuration    @{parametrs}

Testing CLI
    [Tags]    CLI
    [Setup]
    RUN
    Created Directory    Robot directory
