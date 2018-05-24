*** Settings ***
Library           Libraries/mathematic.py
Resource          Resource/ResourceHW4.tsv

*** Test Cases ***
Buy products
    Total discount price    ${product1}    ${product2}
    Total price    ${product1}    ${product2}
