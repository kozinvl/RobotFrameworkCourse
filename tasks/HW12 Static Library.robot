*** Settings ***
Documentation     Creation Static Library (.py file) and the Robot test case (.tsv or .robot file):
...               Precondition (do it manually)
...               cd %windir%
...               use any ultilities to get MD5 for notepad.exe
...               Save MD5 as expected value.
...               Test case steps:
...               Read "Windows" directory (%windir%) to a list variable.
...               Check that "notepad.exe" exists in the list.
...               Calculate MD5 for "notepad.exe"
...               Compare results with expected value.
...               Requirements for Robot Test case:
...               Expected value - must be implemented as global variable
...               Each step (keyword) in the test case must be implemented in Python Static Library.
...               No hardcoded values in the test case.
...               Provide two versions of Static Library.
...               Without class
...               With class
...               Use @keyword decorator
...               Implement the name of keyword to calculate MD5 as dynamic name. Something like "Calc ${file_name} MD5".
...               Test library scope - test case
...               Use debug logging for each function or method in Static Library.
...               Use the module level __all__ attribute to limit what functions become keywords.
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
