@if not exist "%~dp0..\osp.bat" goto notrunning
@%~dp0..\osp.bat %*
@exit /b 0
:notrunning
@echo First you need to run the Open Server Panel!
@exit /b 1
