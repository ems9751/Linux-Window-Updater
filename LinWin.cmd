echo >/dev/null # >nul & GOTO WINDOWS & rem ^
echo '----Linux Updater----'

# ***********************************************************
# * NOTE: If you modify this content, be sure to remove carriage returns (\r) 
# *       from the Linux part and leave them in together with the line feeds 
# *       (\n) for the Windows part. In summary:
# *           New lines in Linux: \n
# *           New lines in Windows: \r\n 
# ***********************************************************

# Linux Bash commands here
sudo apt update -y  || sudo yum update
sudo apt upgrade -y || sudo yum upgrade
echo  "------------Update Complete------------"
echo "Creating cronjob for updates?"
sudo echo "30 23   * * 0  root /usr/bin/apt update -q -y >> /var/log/apt/automaticupdates.log" >> /etc/crontab 
sudo echo "45 23   * * 0  root /usr/bin/apt upgrade -q -y >> /var/log/apt/automaticupdates.log" >> /etc/crontab
echo "-----Cron complete and Updates are automatic--------" 
echo "----------------------------------------------------"
echo "---------------Printing System Log------------------"
cat /var/log/auth.log &> authlog.txt || cat /var/log/secure &> authlog.txt   
echo "-------------Log Printed to Home Folder-------------"

echo "Do you want to reboot the computer?"
read ans
if [ "$ans" = "yes" ] || [ "$ans" = "YES" ]
     then
    echo "==========================================="
    echo     "\e[34m Creating Cron...\e[0m"
    sudo shutdown -r
fi
 

# Then, when all Linux commands are complete, end the script with 'exit'...
exit 0

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

:WINDOWS
echo "Windows Updates"


wuauclt.exe /detectnow /updatenow
sfc /scannow
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate
smc -updateconfig

RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
erase "%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*") do RD /S /Q "%%i"

erase "%LOCALAPPDATA%\Google\Chrome\User Data\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do RD /S /Q "%%i"

erase "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do RD /S /Q "%%i"

