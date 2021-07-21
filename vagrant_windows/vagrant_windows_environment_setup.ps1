$DOCUMENTS = $env:USERPROFILE + "\Documents"

function File-Check
{
    Push-Location $DOCUMENTS'\sensor_transport_team_certs'
    $ret_val = [bool](& 'C:\Program Files\Git\usr\bin\sha256sum.exe' -c sensor_transport_team_key_passphrases.sha256)
    Pop-Location
    return $ret_val
}

$args = "choco install vagrant git -y; Get-Service -Name ssh-agent | Set-Service -StartupType Automatic"
Start-Process powershell.exe -Wait -ArgumentList $args -Verb RunAs

Push-Location $DOCUMENTS
if(($cert_zip = (gci -File ..\Downloads\sensor_transport_team_certs.zip -ErrorAction:SilentlyContinue)) -and (-not (gi sensor_transport_team_certs -ErrorAction:SilentlyContinue))){ try{Expand-Archive $cert_zip}catch{ Write-Host "Decompress failed. Bailing."; return }; if(-not ($result = File-Check)){ Write-Host "Check failed. Bailing."; return } else {Write-Host "Verified: $result"}} elseif(((gci -File sensor_transport_team_certs\sensor_transport_*team* -ErrorAction:SilentlyContinue)).Length -eq 3){ Write-Host "Files already in place. Checking..."; if(-not($result = File-Check)){ Write-Host "check failed"} else {Write-Host "Verified: $result"} } else {Write-Host "Must download files first"}

start-service -name ssh-agent
get-service -name ssh-agent

Push-Location $DOCUMENTS'\sensor_transport_team_certs'
ssh-add .\sensor_transport_dev_team .\sensor_transport_team
Pop-Location

New-Item -ItemType Directory ..\.ssh
Copy-Item Z:\known_hosts C:\Users\IEUser\.ssh\

& 'C:\Program Files\Git\bin\git.exe' config --global core.sshCommand C:/Windows/System32/OpenSSH/ssh.exe
& 'C:\Program Files\Git\bin\git.exe' clone git@github.com:mrgarybutler/sensor_transport_dev.git

Push-Location $DOCUMENTS'\sensor_transport_dev'
#Get-Content README.md
Write-Host $env:CERT_PASS
Write-Host $env:ACCESS_KEY_ID
Write-Host $env:SECRET_ACCESS_KEY
Write-Host $env:KEYPAIR_NAME
Write-Host $env:PRIVATE_KEY_PATH
pause
& 'C:\HashiCorp\Vagrant\bin\vagrant.exe' plugin install --plugin-version 1.0.1 fog-ovirt
& 'C:\HashiCorp\Vagrant\bin\vagrant.exe' plugin install vagrant-aws
$connect_aws = (gci -recurse -Path C:\Users\IEUser\.vagrant.d\gems connect_aws.rb).FullName
Copy-Item -Force '..\vagrant_launch_host\vagrant_windows\connect_aws.rb' $connect_aws
& 'C:\HashiCorp\Vagrant\bin\vagrant.exe' up st_zero
# Restart-Computer -Confirm -Verbose