param(
    [string]$Character = "Jimmy",
    [string]$Text
)

if (-not $Text) {
    Write-Host "You must provide -Text"
    exit
}

$body = @{
    character = $Character
    text      = $Text
    source    = "api"
} | ConvertTo-Json

$response = Invoke-RestMethod `
    -Uri "http://192.168.0.121:8000/direct_character_say" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body

Write-Host "Server replied:"
$response
