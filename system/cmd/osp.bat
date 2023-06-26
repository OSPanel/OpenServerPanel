@if not exist "%~dp0..\..\bin\osp.bat" @echo: & @echo First you need to run the Open Server Panel! & @echo Type the command "ospanel" and press Enter... & @exit /b 1
@"%~dp0..\..\bin\osp.bat" %*
