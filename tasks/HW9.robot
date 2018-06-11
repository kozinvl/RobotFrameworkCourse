*** Settings ***
Suite Setup       Set Up Default Settings Browser
Suite Teardown    Close All Browsers
Library           Selenium2Library
Resource          Resource/ResourceHW9_Page_Items.tsv

*** Test Cases ***
TEST
    [Setup]
    ${title}    Get Title
    Should be Equal as Strings    ${title}    ${TITLE NAME}
    Click button    ${EDIT_BUTTON}
    Alert Should Be Present    Please, select one category
    Click Element    ${FIRST CHECKBOX ON MAIN}
    Select From List By Label    ${CATEGORY LABEL}    Cat4
    Click Button    ${APPLY BUTTON}
    ${text}    Get Text    xpath://*[@id="main"]/div/div[5]/form/table/tbody/tr[1]/td[2]    #row in table
    Should Be Equal As Integers    ${text}    4
    Element Should Be Enabled    ${FIRST CHECKBOX ON MAIN}
    Click Element    ${FIRST CHECKBOX ON MAIN}
    Click Element    ${EDIT_BUTTON}
    Clear Element text    ${SEND TEXT FIELD}
    Input Text    ${SEND TEXT FIELD}    My new comment from RF
    UnSelect Checkbox    ${CHECKBOX_STATUS}
    Click Element    ${ADD CAT 5 IN CATEGORIES}
    Click Element    ${PUSH ONE CATEGORY}
    Click Element    ${SAVE&RETURN}
    Select From List By Label    ${CHANGE STATUS}    Inactive
    Click Button    ${APPLY BUTTON}
    Page Should Contain    My new comment from RF
