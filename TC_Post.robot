*** Settings ***
Library    RequestsLibrary
Library     Collections

*** Variables ***
${base_url}     https://fakerestapi.azurewebsites.net

*** Test Cases ***
Put_CustomerRegistration

    create session    mysession     ${base_url}
    ${body}=    create dictionary    id=123    title=abc    dueDate=2022-03-28T15:10:56.393Z    completed=${true}
    ${header}=      create dictionary    Content-Type=application/json
    ${response}=    post request    mysession   /api/v1/Activities    data=${body}    headers=${header}

    log to console    ${body}
    log to console    ${response.status_code}
    log to console    ${response.content}

    #VALIDATIONS
    ${status_code}=    convert to string    ${response.status_code}
    should be equal    ${status_code}   200
    ${response_body}=   convert to string    ${response.content}

    #should contain    ${response_body}      OPEARTION_SUCCESS
    #should contain    ${response_body}      Operation completed successfully





