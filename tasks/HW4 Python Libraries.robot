*** Settings ***
Documentation     Create folder structure for HW #2.
...               Create resource file and import custom keywords from HW#2.
...               Add HTML format docstrings for python functions. Describe purpose, parameters, examples.
...               Add Robot Framework format documentation for test cases and keywords. Describe purpose, parameters, examples.
...               Create documentation for python keywords with LibDoc in html format
...               Create documentation for robot keywords with TestDoc in html format.
...               Optional: Try to use tables in Documentation section.
Library           Libraries/mathematic.py
Resource          Resource/ResourceHW4.tsv

*** Test Cases ***
Buy products
    Total discount price    ${product1}    ${product2}
    Total price    ${product1}    ${product2}
