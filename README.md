# apicall-composite-action

### Overview

Composite Action to validate the response from an api call in response to a POST Request. The action uses a powershell script to initiate an api call.

### Inputs

- Token: PAT Token to access the api's resources. 
- Header: Header to be sent along with the api request
- RequestBody: Request body for the api call, to be added in json format
- ExpectedOutput: 'Output to compare the api response with'

All inputs to be added as secrets in your repository

### Script 

This action contains a sample script depicting an api call, to add your api details do the following commented changes

```
param(
[string]$token,
[string]$method,
[string]$Header,
[string]$RequestBody,
[string]$ExpectedOutput)



#$Header = "application/vnd.github.v3+json"

# Sample Request Body

#$RequestBody = '{"name":"Created-From-Script,"visibility":"private"}'

#Define your header below

$AuthorizationHeader = @{
    Authorization = 'Bearer ' + $token
    Accept = $Header
} 

$repobody = $RequestBody 


 $getapirequest = @{
		Uri = "https://api.github.com/orgs/CanarysPlayground/repos" #add your api url here
		Method = "Post"
                body = $repobody
		ContentType = "application/json"
		Headers = $AuthorizationHeader
        }

$apiobject = Invoke-RestMethod @getapirequest -TimeoutSec 5000

$output = $apiobject.name

# Expected Output comparision with the generated output

if ($output -ne $ExpectedOutput)
{
	Write-Error "Not an Expected Response"
	
}else { Write-Host "Expected Output" }
```

### Sample Workflow 

```
name: APITest
on:
  workflow_dispatch:

jobs:
  
  build:
    runs-on: windows-latest
    steps:    
      
      - name: Validation Stage
        uses: CanarysPlayground/apicall-composite-action@master
        with:
          Token: ${{secrets.API_TOKEN}}
          Header: ${{secrets.HEADER}}
          RequestBody: ${{secrets.REQUESTBODY}}
          ExpectedOutput: ${{secrets.EXPECTEDOUTPUT}}
    
  deploy:
     runs-on: ubuntu-latest
     needs: build
     steps:
      - uses: actions/checkout@v2
```

If Expected output is not recieved in build, deploy stage will be skipped.
    

