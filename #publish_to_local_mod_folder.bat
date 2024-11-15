@echo OFF

::Constants - Mod Name
set mod_name=RedWallCK2

::Constants - Mod structure inside git repo
set modfiles_folder=.\mod_files\

::Constants - Documents folder location
::          - Check which one exists, and use that one. If there are zero or more than one in existence, throw an error.
::          - NB: "DE" includes DE & NL & possibly others. "EN" includes FR & possibly others.
::          - NB: Folder options immediately below must ***NOT*** have a trailing slash.
set ck_mod_folder_onedrive_en=%userprofile%\OneDrive\Documents\Paradox Interactive\Crusader Kings II\mod
set ck_mod_folder_onedrive_de=%userprofile%\OneDrive\Documenten\Paradox Interactive\Crusader Kings II\mod
set ck_mod_folder_normal_en=%userprofile%\Documents\Paradox Interactive\Crusader Kings II\mod
set ck_mod_folder_normal_de=%userprofile%\Documenten\Paradox Interactive\Crusader Kings II\mod
set ck_mod_folder_onedrive_en_exist=0
set ck_mod_folder_onedrive_de_exist=0
set ck_mod_folder_normal_en_exist=0
set ck_mod_folder_normal_de_exist=0
if exist "%ck_mod_folder_onedrive_en%" (set ck_mod_folder_onedrive_en_exist=1)
if exist "%ck_mod_folder_onedrive_de%" (set ck_mod_folder_onedrive_de_exist=1)
if exist "%ck_mod_folder_normal_en%" (set ck_mod_folder_normal_en_exist=1)
if exist "%ck_mod_folder_normal_de%" (set ck_mod_folder_normal_de_exist=1)
set /a "ck_mod_folder_existence_total=%ck_mod_folder_onedrive_en_exist%+%ck_mod_folder_onedrive_de_exist%+%ck_mod_folder_normal_en_exist%+%ck_mod_folder_normal_de_exist%"
if %ck_mod_folder_existence_total%==1 ( goto ck_mod_folder_found_continue )
:: This error message is only shown if the if statement above fails
echo ERROR! Unable to locate CK2 mod folder!
echo.
echo This script can only proceed if EXACTLY ONE of the following folders exists:
echo      Windows Default (EN): %ck_mod_folder_normal_en%
echo      Windows Default (DE): %ck_mod_folder_normal_de%
echo      OneDrive (EN):        %ck_mod_folder_onedrive_en%
echo      OneDrive (DE):        %ck_mod_folder_onedrive_de%
echo.
echo Please contact an admin for further assistance with this issue.
echo.
echo This process will now exit.
pause
exit
:ck_mod_folder_found_continue
if %ck_mod_folder_onedrive_en_exist%==1 (set ck_mod_folder=%ck_mod_folder_onedrive_en%)
if %ck_mod_folder_onedrive_de_exist%==1 (set ck_mod_folder=%ck_mod_folder_onedrive_de%)
if %ck_mod_folder_normal_en_exist%==1 (set ck_mod_folder=%ck_mod_folder_normal_en%)
if %ck_mod_folder_normal_de_exist%==1 (set ck_mod_folder=%ck_mod_folder_normal_de%)

::Set locations of files
set modfile_name=%mod_name%.mod
set moddir_name=%mod_name%\
set modfile_source=%modfiles_folder%%modfile_name%
set modfile_dest_folder=%ck_mod_folder%\
set modfile_dest=%modfile_dest_folder%%modfile_name%
set moddir_source=%modfiles_folder%%moddir_name%
set moddir_dest_folder=%ck_mod_folder%\
set moddir_dest=%moddir_dest_folder%%moddir_name%

::echo.
::echo Debugging:
::echo modfile_source = %modfile_source%
::if exist %modfile_source% ( echo --- This file or folder exists ) else ( echo --- This file or folder does not exist )
::echo modfile_dest = %modfile_dest%
::if exist %modfile_dest% ( echo --- This file or folder exists ) else ( echo --- This file or folder does not exist )
::echo moddir_source = %moddir_source%
::if exist %moddir_source% ( echo --- This file or folder exists ) else ( echo --- This file or folder does not exist )
::echo moddir_dest = %moddir_dest%
::if exist %moddir_dest% ( echo --- This file or folder exists ) else ( echo --- This file or folder does not exist )
::echo.

::Delete any existing files related to this mod
if exist "%modfile_dest%" ( del /F /Q "%modfile_dest%" )
if exist "%moddir_dest%" (
	del /F /S /Q "%moddir_dest%"
	rmdir /S /Q "%moddir_dest%"
)

::Copy the relevant files for this mod to the CK2 mod folder
xcopy /R /Y /Q /-I "%modfile_source%" "%modfile_dest_folder%"
xcopy /R /Y /Q /S /E /I "%moddir_source%*" "%moddir_dest%"

::Pause, so that the user can see if there were any errors
::pause
::exit