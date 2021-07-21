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
  Push-Location .\vagrant_launch_host\vagrant_windows
  ```
- Set the following environment variables for the Vagrantfile to use
  - $ENV:CERT_PASS="\<github cert password\>"
  - $ENV:ACCESS_KEY_ID="\<key id\>"
  - $ENV:SECRET_ACCESS_KEY="\<access key\>"
  - $ENV:KEYPAIR_NAME="\<aws key pair name\>"
  - $ENV:PRIVATE_KEY_PATH="\<aws local key path\>"
- Ensure your aws private key is accessible to the VM (e.g. copied directly or on Shared Folder)
- Execute run_vagrant_windows_setup.bat
  - Accept the elevation prompt (Install vagrant, git, and start ssh-agent)
  - 
