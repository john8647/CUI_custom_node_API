param(
    [string]$Character = "Jimmy",
    [string]$command = 'image farm'
)

if (-not $command) {
    Write-Host "You must provide -a command: 'image, say or said"
    exit
}

$body = @{
    command = $command
    character = $Character
    source    = "api"
} | ConvertTo-Json

$response = Invoke-RestMethod `
    -Uri "http://192.168.0.121:8000/direct_command" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body

Write-Host "Server replied:"
$response
