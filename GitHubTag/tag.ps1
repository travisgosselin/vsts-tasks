#Variables
param ([string]$Tag, [string]$Repo, [string]$Commit, [string]$Owner, [string]$AuthToken)

Write-Host "Adding GIT tag $Tag for repo $Repo under owner $Owner"

$resource = "https://api.github.com/repos/$Owner/$Repo/git/refs"
Write-Host "Posting to URL: $resource"

$body = @{
    'ref' = "refs/tags/$Tag";
    'sha' = "$Commit"}

$jsonBody = (ConvertTo-Json $body)
Write-Host "Posting with Body: $jsonBody"

$result = Invoke-RestMethod -Method Post -Uri $resource -Body (ConvertTo-Json $body) -Header @{"Authorization" = "token $AuthToken"}

Write-Host $result