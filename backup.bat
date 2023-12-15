@echo off
setlocal

rem Set the source and destination folders
set "sourceFolder=C:\Users\%USERNAME%\AppData\Local\Microsoft\Outlook"
set "destinationFolder=C:\Users\%USERNAME%\Downloads"
set "tarFileName=Backup.tar.gz"
set "zipFileName=Backup.zip"

rem Create the destination folder if it doesn't exist
if not exist "%destinationFolder%" mkdir "%destinationFolder%"

rem Copy .pst and .ost files to the destination folder
echo Copying files...
for %%F in ("%sourceFolder%\*.pst" "%sourceFolder%\*.ost") do (
    copy "%%F" "%destinationFolder%" /Y
)

rem Change directory to the destination folder
pushd "%destinationFolder%"

rem Create a tar.gz archive
tar -cvzf "%tarFileName%" *.pst *.ost

rem Delete .pst and .ost files
del *.pst
del *.ost

rem Rename the tar.gz archive to zip
ren "%tarFileName%" "%zipFileName%"

rem Return to the original directory
popd

echo Backup, cleanup, and rename complete.
pause
