param ([string]$RoomId, [string]$AuthToken, [string]$Title, [string]$Url, [string]$Message, [string]$Color, [string] $JobStatus, [string] $AlwaysPost)

Write-Host "Room ID: $RoomId"
Write-Host "Custom Room ID: $CustomRoomId"
Write-Host "Title: $Title"
Write-Host "Url: $Url"
Write-Host "Message: $Message"
Write-Host "Color: $Message"
Write-Host "Job Status: $JobStatus and Always Post: $AlwaysPost"

# we only want to execute the task if execute on fail is on
if (![string]::IsNullOrWhiteSpace($JobStatus))
{
    $Color = "red"
    if ($JobStatus.ToLower() -eq "succeeded")
    {
        $Color = "green"
        if ($AlwaysPost.ToLower() -ne "true")
        {
            Write-Host "Notification blocked since always post is off, and this job succeeded.... exiting."
            exit 0
        }
    } 
}

# if still no ID, then bail out, we cannot proceed
if ([string]::IsNullOrWhiteSpace($AuthToken))
{
    throw "No auth token provided and could not find one built in for room $RoomId"
    exit 1
} 

# create title hyperlinked if we need too.
$formedTitle = "<b>$Title</b>"
if(![string]::IsNullOrWhiteSpace($Url))
{
    $formedTitle = "<a href='$Url'>$formedTitle</a>"
}

# the body with the details of the message
$body = @{
    color = "$Color"
    message_format = "html"
    message = "$formedTitle<br />$Message"
    notify = "true"
}

# Make the request to hipchat api
$url = "https://api.hipchat.com/v2/room/$RoomId/notification?auth_token=$AuthToken"
Invoke-WebRequest -Uri $url -Method POST -Body (ConvertTo-Json $body) -Headers @{"Content-Type"="application/json"}