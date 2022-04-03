*** Settings ***
Library    RequestsLibrary
Library     Collections

*** Variables ***
${base_url}     https://reqres.in
${id}       2

*** Test Cases ***
Get_User_Info
    create session    kahihi    ${base_url}
    ${response}=    get request    kahihi   /api/users/${id}
    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

    #validations
    ${status_code}=   convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${content_body}=   convert to string    ${response.content}
    should contain    ${content_body}   Janet

    ${Content_type}=     get from dictionary    ${response.headers}     Content-Type
    should be equal    ${Content_type}      application/json; charset=utf-8
