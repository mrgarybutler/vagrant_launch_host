@Echo Off
set proj_dir=C:\Users\IEUser\Documents\vagrant_launch_host\
set setup_file_path=%proj_dir%vagrant_windows\vagrant_windows_environment_setup.ps1
set args=-ExecutionPolicy bypass -File %setup_file_path%
set cmd="& {Start-Process -FilePath powershell.exe -ArgumentList '"%args%"'}"
echo %cmd%

powershell.exe -Command %cmd%