@if not exist "%~dp0temp\OSPanel.lock" exit /b 1
@if not exist "%~dp0bin\osp.bat" exit /b 1
@"%~dp0bin\osp.bat" reset init