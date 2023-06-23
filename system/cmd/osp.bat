@if not exist "%~dp0..\..\bin\osp.bat" @echo: & @echo First you need to run the Open Server Panel! & @exit /b 1
@"%~dp0..\..\bin\osp.bat" %*
