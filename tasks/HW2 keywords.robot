*** Settings ***
Documentation     Create test case "Buy products" which should include:
...               As a user you want to buy two products with discounts.
...               The first product has price is 100. End discount is 5.
...               The second product has price 50. End discount is 0.
...               You have to calculate total price that you should to pay for both products in log it.
...               High level keywords: calculation of discount price, total price.
...               Lower-level keywords: calculation of discount sum, calculation of discount price
...               Custom keywords: mathematical operations \ for: +, -. *, /
...               for manual testers who don't know Python please use attached python file.mathemetical_operations.py
Library           mathematic.py

*** Variables ***
${product1}       100
${product2}       50

*** Test Cases ***
Buy products
    Total price without discount    ${product1}    ${product2}
    Total price with discount    ${product1}    ${product2}

*** Keywords ***
Total price without discount
    [Arguments]    ${arg1}    ${arg2}
    ${sum}=    mathematic.add    ${arg1}    ${arg2}
    Log    summary without discount ${sum}    console=true

Total price with discount
    [Arguments]    ${arg1}    ${arg2}
    ${discount1}=    mathematic.multiply    ${arg1}    5
    ${discount1}=    mathematic.divide    ${discount1}    100
    ${price_discount1}=    mathematic.Subtract    ${arg1}    ${discount1}
    ${discount2}=    mathematic.multiply    ${arg2}    0
    ${discount2}=    mathematic.divide    ${discount2}    100
    ${price_discount2}=    mathematic.Subtract    ${arg2}    ${discount2}
    ${total_discount}=    mathematic.Add    ${price_discount1}    ${price_discount2}
    Log    summary with discount ${total_discount}    console=true
