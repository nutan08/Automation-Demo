*** Settings ***
Library    RequestsLibrary
Library     Collections

*** Variables ***
${base_url}     http://localhost:8080

*** Test Cases ***
TC1:Returns all the video games (GET)
    create session    gamesession   ${base_url}
    ${response}=     get request    gamesession      /app/videogames
    log to console    ${response.status_code}
    log to console    ${response.content}

    #validations
    ${status_code}     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

TC2:Add a new video game (POST)
    create session    gamesession   ${base_url}
    ${body}=    create dictionary    id=63  name=aaa   releaseDate=2022-03-03T15:30:10.362Z     reviewScore=5    category=Spacee  rating=Excellentt
    ${header}=  create dictionary    content-type=application/json
    ${response}=    post request    gamesession     /app/videogames     data=${body}    headers=${header}
    log to console    ${response.status_code}
    log to console    ${response.content}

    #Validation
    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${resp_body}=   convert to string    ${response.content}
    should be equal    ${resp_body}     {"status": "Record Added Successfully"}

TC3:Returns the details of a single game by ID (GET)
    create session    gamesession   ${base_url}
    ${response}=     get request    gamesession      /app/videogames/55
    log to console    ${response.status_code}
    log to console    ${response.content}

    #validations
    ${status_code}     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${resp_body}=    convert to string    ${response.content}
    should contain    ${resp_body}   aaa    #name

TC4:Update an existing video game in the DB by specifying a new body (PUT)
    create session    gamesession   ${base_url}
    ${body}=    create dictionary    id=62  name=bbb   releaseDate=2022-03-03T15:30:10.362Z     reviewScore=4    category=Spacee  rating=Excellentt
    ${header}=  create dictionary    content-type=application/json
    ${response}=    put request    gamesession     /app/videogames/62     data=${body}    headers=${header}
    log to console    ${response.status_code}
    log to console    ${response.content}

    #Validation
    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${resp_body}=   convert to string    ${response.content}
    should contain    ${resp_body}     bbb     #name

TC5:Deletes a video game from the DB by ID (DELETE)
    create session    gamesession   ${base_url}
    ${response}=     delete request    gamesession   /app/videogames/55

    #Validation
    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    ${resp_body}=   convert to string    ${response.content}
    should be equal    ${resp_body}     {"status": "Record Deleted Successfully"}
