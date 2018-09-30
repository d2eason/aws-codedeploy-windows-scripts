Import-Module -Name ServerManager
Install-WindowsFeature Web-Server

$currentRetry = 0;
$success = $false;
$appPool = "DefaultAppPool"

Write-Host "Stopping $appPool"
Stop-WebAppPool -Name $appPool

do{

     $status = (Get-WebAppPoolState -name $appPool).Value
    if ($status -eq "Stopped"){
            $success = $true;
            Write-Host "$appPool is $status."
        }
    else{
        Write-Host "Let's wait a few seconds. $appPool is $status"
        Start-Sleep -s 10
        $currentRetry = $currentRetry + 1;
        }
    }
while (!$success -and $currentRetry -le 4)

WriteHost "Stop IIS"
& iisreset /Stop