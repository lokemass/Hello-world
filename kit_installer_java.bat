@echo off
REM This is a sample script
ECHO======================================================================================
ECHO		Kandi kit installation process has begun
ECHO======================================================================================
ECHO 	This kit installer works only on Windows OS
ECHO 	Based on your network speed, the installation may take a while
ECHO======================================================================================
setlocal ENABLEDELAYEDEXPANSION
REM update below path if required
SET JAVA_LOCATION="C:\Program Files\Java\jdk-18.0.2.1\bin"
SET JAVA_VERSION=18
SET JAVA_DOWNLOAD_URL=https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe
SET REPO_DOWNLOAD_URL=https://github.com/lokemass/Hello-world/releases/download/v1.0/Hello-world-main.zip
SET REPO_NAME=Hello-world-main.zip
SET EXTRACTED_REPO_DIR=Hello-world-main
SET FILE_NAME=Main.java
where /q javac
IF ERRORLEVEL 1 (
	ECHO==========================================================================
    	ECHO Java wasn't found in PATH variable
	ECHO==========================================================================
	IF ERRORLEVEL 1 (
		CALL :Install_java_and_modules
		CALL :Download_repo
	) ELSE (
		CALL :Download_repo
		

	)
) else (
			ECHO==========================================================================
			ECHO Nodejs was detected!
			ECHO==========================================================================
			CALL :Download_repo
			
		
		)	
	)
)
SET /P CONFIRM=Would you like to run the kit (Y/N)?
IF /I "%CONFIRM%" NEQ "Y" (
	ECHO 	To run the kit, follow further instructions of the kit in kandi	
	ECHO==========================================================================
) ELSE (
	ECHO 	Extracting the repo ...	
	ECHO==========================================================================
	tar -xvf %REPO_NAME% 
	cd %EXTRACTED_REPO_DIR%
	javac %FILE_NAME%
	java %FILE_NAME%
IF ERRORLEVEL 1 (
		path=path;%JAVA_LOCATION%\bin 
		javac %FILE_NAME%
		java %FILE_NAME%
	)
	PAUSE

)
EXIT /B %ERRORLEVEL%

:Download_repo
bitsadmin /transfer repo_download_job /download %REPO_DOWNLOAD_URL% "%cd%\%REPO_NAME%"
ECHO==========================================================================
ECHO 	The Kit has been installed successfully
ECHO==========================================================================
ECHO 	To run the kit, follow further instructions of the kit in kandi	
ECHO==========================================================================
EXIT /B 0

:Install_java_and_modules
set path=%path%;!JAVA_LOCATION!
ECHO==========================================================================
ECHO Downloading JAVA%JAVA_VERSION% ... 
ECHO==========================================================================
REM curl -o jdk-18_windows-x64_bin.exe %JAVA_DOWNLOAD_URL%
bitsadmin /transfer Java_download_job /download %JAVA_DOWNLOAD_URL% "%cd%\jdk-18_windows-x64_bin.exe"
ECHO Installing java-v%JAVA_VERSION% ...
jdk-18_windows-x64_bin.exe /quiet
ECHO==========================================================================
ECHO Java JDK installed in path : %JAVA_LOCATION%
ECHO==========================================================================
IF ERRORLEVEL 1 (
		ECHO==========================================================================
		ECHO There was an error while installing Java!
		ECHO==========================================================================
		start jdk-18_windows-x64_bin.exe
		EXIT /B 1
)
EXIT /B 0
