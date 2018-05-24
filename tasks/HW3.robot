*** Settings ***
Library           Collections
Resource          Resource/ResourceHW3.tsv

*** Test Cases ***
Scalar variables
    message    ${scalar}
    another message

List variables
    Push your list    @{list}
    Create new list    @{clear list}
    Update your list    @{list}

Dictionary variables
    create and log dictionaries
    update and remove your dict    &{dictionary}
    nested dict?    Yes    &{dictionary}
    Log with navigation
