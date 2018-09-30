Import-Module -Name ServerManager
$appPool = "DefaultAppPool"

Write-Host "Starting $appPool"
Start-WebAppPool -Name $appPool

Write-Host "Resetting IIS"
& iisreset /start