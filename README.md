# vagrant_launch_host
This repository sets up the vagrant environment for various scenarios

- Import VM.
- Snapshot VM.
- Start VM.
- Login to VM.
- Open IE and click Sharepoint favorites link to download 'sensor_transport_team_certs.zip' into Downloads folder.
- Download and unzip this repository https://github.com/mrgarybutler/vagrant_launch_host/archive/refs/heads/develop.zip
  ```Powershell
  Push-Location C:\Users\IEUser\Documents
  Invoke-Webrequest -Uri "https://github.com/mrgarybutler/vagrant_launch_host/archive/refs/heads/develop.zip" -OutFile develop.zip
  Expand-Archive -Path .\develop.zip -DestinationPath .
  mv vag*-* (gi v*).Name.Split("-")[0]
  ```
- Open the 
