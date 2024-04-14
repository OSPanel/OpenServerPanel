@echo off
setlocal
set "PATH={root_dir}\addons\{addon_name};{root_dir}\addons\{addon_name}\nodejs;%PATH%"
set "SYS_ARCH=64"
set "NVM_HOME={root_dir}\addons\{addon_name}"
set "NVM_SYMLINK={root_dir}\addons\{addon_name}\nodejs"
{root_dir}\addons\{addon_name}\nvm.exe %*
endlocal
exit /b 0