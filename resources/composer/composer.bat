@if /i "%1"=="self-update" @curl -f -s -L -o "%COMPOSER_HOME%\keys.dev.pub" https://composer.github.io/snapshots.pub && @curl -f -s -L -o "%COMPOSER_HOME%\keys.tags.pub" https://composer.github.io/releases.pub
@php.exe -d output_buffering=0 "%COMPOSER_HOME%\composer.phar" %*
