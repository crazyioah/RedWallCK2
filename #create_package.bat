@echo OFF

::Constants - Mod Name
set mod_name=RedWallCK2

::Constants - Mod structure inside git repo
set modfiles_folder=.\mod_files\

::Constants - Other
set zip_loc=.\_utilities\7z_CmdLine\7z.exe

::Set locations of files
set zipped_mod_filepath=.\packaged_mod\%mod_name%.zip

::Delete any pre-existing zipped version of the mod
if exist %zipped_mod_filepath% (
	del /F /Q %zipped_mod_filepath%
	if exist %zipped_mod_filepath% (
		pause
		exit
	)
)

::Create package
%zip_loc% a -r -tzip %zipped_mod_filepath% %modfiles_folder%*