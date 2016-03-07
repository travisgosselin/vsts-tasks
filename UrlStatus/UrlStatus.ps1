#Variables
param ([string]$Url, [string]$RequiredContent)

Write-Host "Going to send GET request to $Url looking for content '$RequiredContent'"

# make the request to the public url
$req = [system.Net.WebRequest]::Create($Url)
try {
    $res = $req.GetResponse()
} catch [System.Net.WebException] {
    $res = $_.Exception.Response
}

# write out the results fo the status code
$statusCode = [int]$res.StatusCode
Write-Host "Found status code: $statusCode"

# write out whatever is in the response for logging purposes
if ($statusCode -gt 0)
{
    $reqstream = $res.GetResponseStream()
    $sr = new-object System.IO.StreamReader $reqstream
    $result = $sr.ReadToEnd()
    Write-Host "Result of request: $result"
}

# determine success or failure of the status
if ($statusCode -eq 200 -Or $statusCode -eq 204){
    # status code was good, check if required content was
    if (![string]::IsNullOrEmpty($RequiredContent)) {
        if ($result.ToLower() -Match $RequiredContent.ToLower())
        {
            Write-Host "Found the required content. Url Check Successful."
        }
        else{
            throw "Could not find the required content on the page, URL check failed!"
        }
    } else{
        Write-Host "Status code is good, and no required content to check on the page. Url Check Successful."  
    }
} else {
    throw "Failed URL Status check with status code: $statusCode"
}