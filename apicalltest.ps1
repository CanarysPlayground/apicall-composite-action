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
