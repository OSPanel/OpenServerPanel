# ================================================================================
#              AUTOMATED OSPANEL ADDONS AND UTILITIES BUILD SCRIPT
# ================================================================================
# Description: Automated OSPanel addons build from JSON configuration
#              and system utilities installation
# Author:      OSPanel Dev Team
# ================================================================================

# ================== SCRIPT CONFIGURATION ==================
$JsonPath       = "..\resources\matrix\matrix-infodata.json"
$BinMatrixPath  = "..\resources\matrix\matrix-bin.json"
$BaseAddonsDir  = "..\addons"
$BaseBinDir     = "..\bin"
$CacheDir       = "..\cache"  # Cache directory for downloaded files
$UseProxy       = $false
$ProxyUrl       = "127.0.0.1:1086"
# ==========================================================

# ================== GLOBAL COUNTERS ==================
$script:TotalAddons = 0
$script:ProcessedAddons = 0
$script:SkippedAddons = 0
$script:FailedAddons = 0

$script:TotalTools = 0
$script:ProcessedTools = 0
$script:SkippedTools = 0
$script:FailedTools = 0

$script:TotalModules = 0
$script:ProcessedModules = 0
$script:SkippedModules = 0
$script:FailedModules = 0

# Variables for tracking execution stages
$script:CurrentMainStep = 0
$script:TotalMainSteps = 9
$script:CurrentAddonSubStep = 0
$script:TotalAddonSubSteps = 6
$script:CurrentToolSubStep = 0
$script:TotalToolSubSteps = 3
# ===========================================================

# ================== COMMON HELPERS ==================
function Write-Banner {
    param([string]$Text, [string]$Color = "Cyan")
    $line = "═" * 80
    Write-Host $line -ForegroundColor $Color
    Write-Host " $Text" -ForegroundColor $Color
    Write-Host $line -ForegroundColor $Color
}

function Write-Stage {
    param([string]$ComponentName, [string]$Step, [string]$Details = "", [ConsoleColor]$Color = [ConsoleColor]::Green)
    $status = if ($Details) { "$Step - $Details" } else { $Step }
    Write-Host "$ComponentName" -ForegroundColor White -NoNewline
    Write-Host " → $status" -ForegroundColor $Color
}

function Write-Success { param([string]$Message) Write-Host "✓ $Message" -ForegroundColor Green }
function Write-Warning { param([string]$Message) Write-Host "⚠ $Message" -ForegroundColor Yellow }
function Write-Error   { param([string]$Message) Write-Host "✗ $Message" -ForegroundColor Red }
function Write-Skip    { param([string]$Message) Write-Host "⏭  $Message" -ForegroundColor Cyan }

function New-DirectoryIfNotExists {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]$FilePath
    )
    $directory = Split-Path -Path $FilePath -Parent
    if ($directory -and -not (Test-Path -Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }
}

function New-ParentDirectory { param([string]$Path) New-DirectoryIfNotExists -FilePath $Path }

function New-TempDir {
    $dir = Join-Path $env:TEMP ("tmpdir_" + (Get-Random))
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    return $dir
}

function Expand-Zip {
    param([string]$ZipPath, [string]$DestDir)
    Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
}

function Move-AllChildren {
    param([string]$SourceDir, [string]$DestDir)
    Get-ChildItem -Path $SourceDir | ForEach-Object {
        Move-Item -Path $_.FullName -Destination $DestDir -Force
    }
}

function Remove-DirectoriesIfExists {
    param([string]$Base, [string[]]$Dirs)
    $removed = 0
    foreach ($d in $Dirs) {
        $p = Join-Path $Base $d
        if (Test-Path $p) {
            Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue
            Write-Success "Removed directory: $d"
            $removed++
        }
    }
    return $removed
}

function Remove-FilesByPatterns {
    param(
        [string]$Base,
        [string[]]$Patterns,
        [switch]$Recurse
    )
    $count = 0
    foreach ($pat in $Patterns) {
        $files = Get-ChildItem -Path $Base -Filter $pat -File -ErrorAction SilentlyContinue -Recurse:$Recurse
        foreach ($f in $files) {
            Remove-Item $f.FullName -Force -ErrorAction SilentlyContinue
            $count++
        }
    }
    if ($count -gt 0) {
        Write-Success "Removed $count files by patterns: $($Patterns -join ', ')"
    }
    return $count
}

function Move-FromZipSubfolder {
    param(
        [string]$ZipPath,
        [string]$DestDir,
        [string]$Filter # e.g. "Apache*", "mysql*", "pgsql"
    )
    $tmpDir = New-TempDir
    try {
        Expand-Zip -ZipPath $ZipPath -DestDir $tmpDir
        $matchDir = Get-ChildItem -Path $tmpDir -Directory -ErrorAction SilentlyContinue |
                    Where-Object { $_.Name -like $Filter } |
                    Select-Object -First 1
        if ($matchDir) {
            Move-AllChildren -SourceDir $matchDir.FullName -DestDir $DestDir
            Write-Success "Moved files from $($matchDir.Name) to module root"
        } else {
            Move-AllChildren -SourceDir $tmpDir -DestDir $DestDir
            Write-Success "Files moved directly to module root"
        }
        return $true
    } catch {
        Write-Error "Extraction error: $_"
        return $false
    } finally {
        Remove-Item $tmpDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# ================== CACHE HELPERS ==================
function Get-CacheFileName {
    param([string]$Url)
    # Create a safe filename from URL by replacing special characters
    $safeFileName = $Url -replace '[\\/:"*?<>|]', '_'
    $safeFileName = $safeFileName -replace 'https?_+', ''
    $safeFileName = $safeFileName -replace '_+', '_'
    $safeFileName = $safeFileName.Trim('_')
    return "$safeFileName"
}

function Get-CachedFile {
    param([string]$Url, [string]$OutFile)

    # Ensure cache directory exists
    if (-not (Test-Path $CacheDir)) {
        New-Item -ItemType Directory -Path $CacheDir -Force | Out-Null
        Write-Success "Created cache directory: $CacheDir"
    }

    $cacheFileName = Get-CacheFileName -Url $Url
    $cachedFilePath = Join-Path $CacheDir $cacheFileName

    # Check if file exists in cache
    if (Test-Path $cachedFilePath) {
        Write-Stage "CACHE" "Using cached file" $cacheFileName
        Copy-Item $cachedFilePath $OutFile -Force
        Write-Success "File retrieved from cache"
        return $true
    }

    # Download to cache first
    Write-Stage "DOWNLOAD" "Downloading to cache" $Url
    $downloadSuccess = Invoke-Curl -Url $Url -OutFile $cachedFilePath -Silent -Follow -Fail

    if (($downloadSuccess -eq 0) -and (Test-Path $cachedFilePath) -and (Get-Item $cachedFilePath).Length -gt 0) {
        $fileSize = [math]::Round((Get-Item $cachedFilePath).Length / 1MB, 2)
        Write-Success "File downloaded to cache ($fileSize MB)"
        Copy-Item $cachedFilePath $OutFile -Force
        return $true
    }

    Write-Error "Failed to download file: $Url"
    return $false
}

function Invoke-Curl {
    param(
        [Parameter(Mandatory = $true)]
        [string] $Url,

        [Parameter(Mandatory = $true)]
        [string] $OutFile,

        [switch] $Silent,
        [switch] $Follow,
        [switch] $Fail = $true,

        # Опционально: SOCKS5-прокси
        [switch] $UseProxy,
        [string] $ProxyUrl
    )

    if ([string]::IsNullOrWhiteSpace($Url))     { throw "Invoke-Curl: Url is empty." }
    if ([string]::IsNullOrWhiteSpace($OutFile)) { throw "Invoke-Curl: OutFile is empty." }

    # Базовая директория для относительного пути ..\system\bin\curl.exe
    $baseDir = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

    # Сформировать абсолютный путь к ..\system\bin\curl.exe
    # ..\ от baseDir
    $curlPath = Join-Path -Path (Join-Path -Path $baseDir -ChildPath '..\system\bin') -ChildPath 'curl.exe'
    $curlPath = [System.IO.Path]::GetFullPath($curlPath)

    if (-not (Test-Path -LiteralPath $curlPath)) {
        throw "Invoke-Curl: Forced curl not found at '$curlPath'."
    }

    # Гарантировать каталог назначения
    $dir = [System.IO.Path]::GetDirectoryName($OutFile)
    if (-not [string]::IsNullOrWhiteSpace($dir)) {
        if (-not (Test-Path -LiteralPath $dir)) {
            try {
                New-Item -ItemType Directory -Path $dir -Force | Out-Null
            } catch {
                throw "Invoke-Curl: Failed to create directory '$dir'. $_"
            }
        }
    }

    # Сбор аргументов
    $myargs = @()

    if ($UseProxy) {
        if ([string]::IsNullOrWhiteSpace($ProxyUrl)) {
            throw "Invoke-Curl: ProxyUrl must be specified when -UseProxy is set."
        }
        $myargs += @('--socks5', $ProxyUrl)
        # Для HTTP-прокси можно использовать: $myargs += @('-x', $ProxyUrl)
    }

    if ($Fail)   { $myargs += '-f' }       # или '--fail-with-body' если ваша сборка curl поддерживает
    if ($Follow) { $myargs += '-L' }

    if ($Silent) { $myargs += @('-s', '-S') } else { $myargs += '-S' }

    $myargs += @('-o', $OutFile, $Url)

    # Запуск строго указанного curl.exe
    & $curlPath $myargs
    $code = $LASTEXITCODE
    return $code
}

# ================== INI HELPERS ==================
function Format-IniLine {
    param ([string]$Key, [string]$Value)
    $padding = 25 - $Key.Length
    if ($padding -lt 1) { $padding = 1 }
    $spaces = " " * $padding
    return "$Key$spaces= $Value"
}

function Convert-ToIni {
    param ([string]$SectionName, [object]$Data)
    $lines = @()
    $lines += "[$SectionName]"
    $lines += ""
    $props = $Data.PSObject.Properties | Sort-Object Name
    foreach ($prop in $props) {
        if ($prop.Value -is [PSCustomObject]) {
            $lines += Convert-ToIni -SectionName $prop.Name -Data $prop.Value
        } elseif ($prop.Value -is [System.Collections.IDictionary]) {
            foreach ($kv in ($prop.Value.GetEnumerator() | Sort-Object Key)) {
                $lines += (Format-IniLine $kv.Key $kv.Value)
            }
        } else {
            $lines += (Format-IniLine $prop.Name $prop.Value)
        }
    }
    return $lines
}

# ================== PREREQUISITES / CONFIG LOAD ==================
function Test-Prerequisites {
    Write-Stage "SYSTEM" "Checking prerequisites"
    if (-not (Test-Path $JsonPath)) { Write-Error "Addons configuration file not found: $JsonPath"; return $false }
    if (-not (Test-Path $BinMatrixPath)) { Write-Error "Utilities configuration file not found: $BinMatrixPath"; return $false }
    try { $null = Get-Command curl -ErrorAction Stop; Write-Success "Curl utility found" }
    catch { Write-Error "Curl utility not found in system"; return $false }
    if ($UseProxy) { Write-Success "Proxy enabled: $ProxyUrl" } else { Write-Success "Direct connection mode enabled" }
    Write-Success "All prerequisites met"
    return $true
}

function Get-AddonsList {
    try {
        Write-Stage "SYSTEM" "Loading addons configuration"
        $infodata = Get-Content $JsonPath -Raw | ConvertFrom-Json
        $addons = $infodata.addons.PSObject.Properties.Name | Sort-Object -Unique
        $script:TotalAddons = $addons.Count
        Write-Success "Loaded $($script:TotalAddons) addons from configuration"
        return @{ InfoData = $infodata; Addons = $addons }
    } catch { Write-Error "Error loading addons configuration: $_"; return $null }
}

function Get-ToolsList {
    try {
        Write-Stage "SYSTEM" "Loading utilities configuration"
        $binMatrix = Get-Content $BinMatrixPath -Raw | ConvertFrom-Json
        $tools = $binMatrix.tools
        $script:TotalTools = $tools.Count
        Write-Success "Loaded $($script:TotalTools) utilities from configuration"
        return $binMatrix
    } catch { Write-Error "Error loading utilities configuration: $_"; return $null }
}

function Get-ModulesList {
    try {
        Write-Stage "SYSTEM" "Loading modules configuration"
        $infodata = Get-Content $JsonPath -Raw | ConvertFrom-Json
        $modules = $infodata.modules.PSObject.Properties.Name | Sort-Object -Unique
        $script:TotalModules = $modules.Count
        Write-Success "Loaded $($script:TotalModules) modules from configuration"
        return @{ InfoData = $infodata; Modules = $modules }
    } catch { Write-Error "Error loading modules configuration: $_"; return $null }
}

# ================== DOWNLOAD / EXTRACT (ADDONS) ==================
function Get-Addon {
    param([string]$DownloadUrl, [string]$ZipPath)
    try {
        return Get-CachedFile -Url $DownloadUrl -OutFile $ZipPath
    } catch { Write-Error "Error during download: $_"; return $false }
}

function Install-InstantClient {
    param([string]$DestDir)
    try {
        Write-Stage "INSTANTCLIENT" "Special processing InstantClient"
        $archives = @(
            "https://download.oracle.com/otn_software/nt/instantclient/instantclient-odbc-windows.zip",
            "https://download.oracle.com/otn_software/nt/instantclient/instantclient-jdbc-windows.zip",
            "https://download.oracle.com/otn_software/nt/instantclient/instantclient-tools-windows.zip",
            "https://download.oracle.com/otn_software/nt/instantclient/instantclient-sqlplus-windows.zip",
            "https://download.oracle.com/otn_software/nt/instantclient/instantclient-basic-windows.zip"
        )
        if (-not (Test-Path $DestDir)) { New-Item -ItemType Directory -Force -Path $DestDir | Out-Null }
        $downloadedFiles = @()
        foreach ($downloadUrl in $archives) {
            $fileName = Split-Path $downloadUrl -Leaf
            $zipPath = Join-Path (Get-Location) $fileName
            Write-Stage "INSTANTCLIENT" "Downloading $fileName"
            if (Get-CachedFile -Url $downloadUrl -OutFile $zipPath) { $downloadedFiles += $zipPath }
            else { Write-Warning "Failed to download $fileName, continuing with others" }
        }
        if ($downloadedFiles.Count -eq 0) { Write-Error "Failed to download any InstantClient archives"; return $false }
        Write-Success "Downloaded $($downloadedFiles.Count) of $($archives.Count) archives"
        foreach ($zipFile in $downloadedFiles) {
            Write-Stage "INSTANTCLIENT" "Extracting $(Split-Path $zipFile -Leaf)"
            try {
                Expand-Archive -Path $zipFile -DestinationPath $DestDir -Force
                Remove-Item $zipFile -Force
                Write-Success "Archive $(Split-Path $zipFile -Leaf) extracted and deleted"
            } catch { Write-Warning "Error extracting $(Split-Path $zipFile -Leaf): $_" }
        }
        $instantclientDir = Get-ChildItem -Path $DestDir -Directory -Filter "instantclient*" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($instantclientDir) {
            Write-Stage "INSTANTCLIENT" "Moving files from $($instantclientDir.Name)"
            Get-ChildItem -Path $instantclientDir.FullName | ForEach-Object {
                $destPath = Join-Path $DestDir $_.Name
                if ($_.PSIsContainer) {
                    if (Test-Path $destPath) {
                        Copy-Item -Path (Join-Path $_.FullName "*") -Destination $destPath -Recurse -Force
                    } else {
                        Move-Item -Path $_.FullName -Destination $destPath -Force
                    }
                } else {
                    Move-Item -Path $_.FullName -Destination $destPath -Force
                }
            }
            Remove-Item $instantclientDir.FullName -Force
            Write-Success "Files moved from $($instantclientDir.Name), subfolder removed"
        }
        $metaInfDir = Join-Path $DestDir "META-INF"
        if (Test-Path $metaInfDir) { Remove-Item $metaInfDir -Recurse -Force; Write-Success "META-INF subfolder removed" }
        Write-Success "InstantClient special processing completed"
        return $true
    } catch { Write-Error "Error processing InstantClient: $_"; return $false }
}

function Install-ImageMagick {
    param([string]$DestDir)
    try {
        Write-Stage "IMAGEMAGICK" "Reorganizing files"
        $binDir = Join-Path $DestDir "bin"
        if (Test-Path $binDir) {
            Get-ChildItem -Path $binDir | ForEach-Object {
                $destPath = Join-Path $DestDir $_.Name
                Move-Item -Path $_.FullName -Destination $destPath -Force
            }
            Write-Success "Files moved from bin to root"
            Remove-Item $binDir -Force
            Write-Success "Bin folder removed"
        }
        $codersDir = Join-Path $DestDir "coders"
        if (-not (Test-Path $codersDir)) { New-Item -ItemType Directory -Force -Path $codersDir | Out-Null }
        $imFiles = Get-ChildItem -Path $DestDir -Filter "IM_*.dll" -ErrorAction SilentlyContinue
        if ($imFiles) {
            $imFiles | ForEach-Object { Move-Item -Path $_.FullName -Destination (Join-Path $codersDir $_.Name) -Force }
            Write-Success "Moved $($imFiles.Count) IM_*.dll files to coders folder"
        }
        $filtersDir = Join-Path $DestDir "filters"
        if (-not (Test-Path $filtersDir)) { New-Item -ItemType Directory -Force -Path $filtersDir | Out-Null }
        $filterFiles = Get-ChildItem -Path $DestDir -Filter "FILTER_*.dll" -ErrorAction SilentlyContinue
        if ($filterFiles) {
            $filterFiles | ForEach-Object { Move-Item -Path $_.FullName -Destination (Join-Path $filtersDir $_.Name) -Force }
            Write-Success "Moved $($filterFiles.Count) FILTER_*.dll files to filters folder"
        }
        $imconfigDir = Join-Path $DestDir "config"
        if (-not (Test-Path $imconfigDir)) { New-Item -ItemType Directory -Force -Path $imconfigDir | Out-Null }
        $xmlFiles = Get-ChildItem -Path $DestDir -Filter "*.xml" -ErrorAction SilentlyContinue
        if ($xmlFiles) {
            $xmlFiles | ForEach-Object { Move-Item -Path $_.FullName -Destination (Join-Path $imconfigDir $_.Name) -Force }
            Write-Success "Moved $($xmlFiles.Count) *.xml files to config folder"
        }
        Write-Success "ImageMagick special processing completed"
    } catch { Write-Error "Error processing ImageMagick: $_" }
}

function Expand-Addon {
    param([string]$AddonName, [string]$ZipPath, [string]$DestDir, [string]$DownloadUrl = "")
    try {
        Write-Stage "EXTRACTION" "Extracting archive"
        if (-not (Test-Path $DestDir)) { New-Item -ItemType Directory -Force -Path $DestDir | Out-Null }
        switch -Wildcard ($AddonName) {
            "InstantClient" {
                Write-Stage "EXTRACTION" "Special InstantClient processing"
                return (Install-InstantClient -DestDir $DestDir)
            }
            "ImageMagick-*" {
                Write-Stage "EXTRACTION" "Special ImageMagick processing"
                Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
                Install-ImageMagick -DestDir $DestDir
            }
            "DB2-ODBC" {
                Write-Stage "EXTRACTION" "Special DB2-ODBC processing"
                $tmpDir = Join-Path $DestDir "_tmp"
                if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
                Expand-Archive -Path $ZipPath -DestinationPath $tmpDir -Force
                $clidriver = Join-Path $tmpDir "clidriver"
                if (Test-Path $clidriver) {
                    Get-ChildItem -Path $clidriver | ForEach-Object { Move-Item -Path $_.FullName -Destination $DestDir -Force }
                }
                Remove-Item $tmpDir -Recurse -Force
            }
            "FFMpeg" {
                Write-Stage "EXTRACTION" "Special FFMpeg processing"
                $tmpDir = Join-Path $DestDir "_tmp"
                if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
                Expand-Archive -Path $ZipPath -DestinationPath $tmpDir -Force
                $ffmpegDir = Get-ChildItem -Path $tmpDir -Directory -Filter "ffmpeg*" | Select-Object -First 1
                if ($ffmpegDir) { Get-ChildItem -Path $ffmpegDir.FullName | ForEach-Object { Move-Item -Path $_.FullName -Destination $DestDir -Force } }
                Remove-Item $tmpDir -Recurse -Force
            }
            "Libwebp" {
                Write-Stage "EXTRACTION" "Special Libwebp processing"
                $tmpDir = Join-Path $DestDir "_tmp"
                if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
                Expand-Archive -Path $ZipPath -DestinationPath $tmpDir -Force
                $libwebpDir = Get-ChildItem -Path $tmpDir -Directory -Filter "Libwebp*" | Select-Object -First 1
                if ($libwebpDir) { Get-ChildItem -Path $libwebpDir.FullName | ForEach-Object { Move-Item -Path $_.FullName -Destination $DestDir -Force } }
                Remove-Item $tmpDir -Recurse -Force
            }
            "MongoTools" {
                Write-Stage "EXTRACTION" "Special Mongo Tools processing"
                $tmpDir = Join-Path $DestDir "_tmp"
                if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
                Expand-Archive -Path $ZipPath -DestinationPath $tmpDir -Force
                $toolsDir = Get-ChildItem -Path $tmpDir -Directory -Filter "*mongodb*" | Select-Object -First 1
                if ($toolsDir) { Get-ChildItem -Path $toolsDir.FullName | ForEach-Object { Move-Item -Path $_.FullName -Destination $DestDir -Force } }
                Remove-Item $tmpDir -Recurse -Force
            }
            "MongoShell" {
                Write-Stage "EXTRACTION" "Special Mongo Shell processing"
                $tmpDir = Join-Path $DestDir "_tmp"
                if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
                Expand-Archive -Path $ZipPath -DestinationPath $tmpDir -Force
                $shellDir = Get-ChildItem -Path $tmpDir -Directory -Filter "*mongosh*" | Select-Object -First 1
                if ($shellDir) { Get-ChildItem -Path $shellDir.FullName | ForEach-Object { Move-Item -Path $_.FullName -Destination $DestDir -Force } }
                Remove-Item $tmpDir -Recurse -Force
            }
            default {
                Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
                Remove-Item $ZipPath -Force
            }
        }
        if ($AddonName -ne "InstantClient") {
            if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
        }
        Write-Success "Archive successfully extracted and deleted"
        return $true
    } catch { Write-Error "Error extracting archive: $_"; return $false }
}

# ================== HELP GENERATION (COMMON) ==================
function Write-HelpForExecutables {
    param(
        [string]$RootDir,
        [string]$HelpDir,
        [string]$DefaultHelpSwitch = "--help",
        [string[]]$ExcludeExeNames = @()
    )
    if (-not (Test-Path $HelpDir)) { New-Item -ItemType Directory -Force -Path $HelpDir | Out-Null }
    $executables = Get-ChildItem -Path $RootDir -Filter *.exe -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $ExcludeExeNames -notcontains $_.Name }
    if (-not $executables) { Write-Warning "No executable files found"; return 0 }
    $generated = 0
    foreach ($exe in $executables) {
        $outFile = Join-Path $HelpDir ($exe.BaseName + ".txt")
        try {
            $myargs = if ($DefaultHelpSwitch) { $DefaultHelpSwitch -split "\s+" } else { @() }
            $output = & $exe.FullName @($myargs) 2>&1
            $filteredOutput = $output | Where-Object { $_.ToString().Trim() -ne "" }
            if ($filteredOutput) { $filteredOutput | Out-File -FilePath $outFile -Encoding utf8; $generated++ }
            else { Write-Warning "Empty help output for $($exe.Name)" }
        } catch { Write-Warning "Error generating help for $($exe.Name): $_" }
    }
    return $generated
}

# ================== ADDONS: HELP/INI/COPY ==================
function New-HelpFiles {
    param([string]$AddonName, [string]$DestDir, [object]$Addon)
    Write-Stage "HELP" "Generating help files"
    $HelpDir = "$DestDir\ospanel_data\help"
    if (-not (Test-Path $HelpDir)) { New-Item -ItemType Directory -Force -Path $HelpDir | Out-Null }
    if ($AddonName -like "ErlangOTP*" -or $AddonName -eq "NVM") {
        Write-Skip "Help generation skipped for $AddonName"
        return
    }
    $helpCmd = if ($Addon.help) { $Addon.help } else { "--help" }
    $exclude = @('gswin64.exe')
    if ($AddonName -in @("DB2-ODBC")) {
        $executables = Get-ChildItem -Path (Join-Path $DestDir "bin") -Filter *.exe -Recurse -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -notin $exclude }
        $generated = 0
        foreach ($exe in $executables) {
            $outFile = Join-Path $HelpDir ($exe.BaseName + ".txt")
            try {
                $myargs = $helpCmd -split "\s+"
                $output = & $exe.FullName @($myargs) 2>&1
                $filteredOutput = $output | Where-Object { $_.ToString().Trim() -ne "" }
                if ($filteredOutput) { $filteredOutput | Out-File -FilePath $outFile -Encoding utf8; $generated++ }
                else { Write-Warning "Empty help output for $($exe.Name)" }
            } catch { Write-Warning "Error generating help for $($exe.Name): $_" }
        }
        Write-Success "Created $generated help files"
        return
    } elseif ($AddonName -like "ImageMagick-*") {
        # For ImageMagick execute without parameters
        $executables = Get-ChildItem -Path $DestDir -Filter *.exe -Recurse -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -notin $exclude }
        $generated = 0
        foreach ($exe in $executables) {
            $outFile = Join-Path $HelpDir ($exe.BaseName + ".txt")
            try {
                $output = & $exe.FullName 2>nul
                $filteredOutput = $output | Where-Object { $_.ToString().Trim() -ne "" }
                if ($filteredOutput) { $filteredOutput | Out-File -FilePath $outFile -Encoding utf8; $generated++ }
            } catch { Write-Warning "Error generating help for $($exe.Name): $_" }
        }
        Write-Success "Created $generated help files"
        return
    } else {
        [void](Write-HelpForExecutables -RootDir $DestDir -HelpDir $HelpDir -DefaultHelpSwitch $helpCmd -ExcludeExeNames $exclude)
    }
}

function New-IniFile {
    param([string]$DestDir, [object]$Addon)
    Write-Stage "CONFIGURATION" "Creating addon.ini"
    $IniPath = "$DestDir\ospanel_data\addon.ini"
    $sectionsOrder = @("main", "docs", "environment")
    $skipSections = @("DownloadUrl", "ZipPath", "help")
    $iniContent = @()
    foreach ($sec in $sectionsOrder) {
        if ($Addon.PSObject.Properties.Name -contains $sec) {
            $iniContent += Convert-ToIni -SectionName $sec -Data $Addon.$sec
            $iniContent += ""
        }
    }
    $otherSections = $Addon.PSObject.Properties.Name |
                     Where-Object { $sectionsOrder -notcontains $_ -and $skipSections -notcontains $_ } |
                     Sort-Object
    foreach ($sec in $otherSections) {
        $iniContent += Convert-ToIni -SectionName $sec -Data $Addon.$sec
        $iniContent += ""
    }
    $iniDir = Split-Path $IniPath -Parent
    if (-not (Test-Path $iniDir)) { New-Item -ItemType Directory -Force -Path $iniDir | Out-Null }
    $iniContent | Out-File -FilePath $IniPath -Encoding ascii -Force
    Write-Success "addon.ini file created"
}

function Copy-BundleFiles {
    param([string]$AddonName, [string]$DestDir)
    $bundleSrc = "..\resources\addons\$AddonName"
    if (Test-Path $bundleSrc) {
        Write-Stage "COPYING" "Additional files from bundle"
        try { Copy-Item -Path (Join-Path $bundleSrc "*") -Destination $DestDir -Recurse -Force; Write-Success "Additional files copied" }
        catch { Write-Warning "Error copying additional files: $_" }
    }
}

# ================== CLEANUP ADDONS ==================
function Remove-UnnecessaryFiles {
    Write-Host ""
    $excludePatterns = @("ErlangOTP*", "Ghostscript*")
    $excludedDirs = foreach ($pattern in $excludePatterns) { Get-ChildItem -Path $BaseAddonsDir -Directory -Filter $pattern }
    foreach ($excludedDir in $excludedDirs) {
        Write-Stage "CLEANUP" "Special cleanup for $($excludedDir.Name)"
        Get-ChildItem -Path $excludedDir.FullName -Filter "*vc_redist.exe" -ErrorAction SilentlyContinue |
            ForEach-Object { Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: $($_.Name)" }
        Get-ChildItem -Path $excludedDir.FullName -Directory -Filter "erts*" -ErrorAction SilentlyContinue | ForEach-Object {
            $libPath = Join-Path $_.FullName "lib"
            $includePath = Join-Path $_.FullName "include"
            if (Test-Path $libPath) { Remove-Item $libPath -Recurse -Force -ErrorAction SilentlyContinue; Write-Success "Removed: $libPath" }
            if (Test-Path $includePath) { Remove-Item $includePath -Recurse -Force -ErrorAction SilentlyContinue; Write-Success "Removed: $includePath" }
        }
        $usrLibPath = Join-Path $excludedDir.FullName "usr\lib"
        if (Test-Path $usrLibPath) {
            Get-ChildItem -Path $usrLibPath -Filter "*.lib" -ErrorAction SilentlyContinue | ForEach-Object {
                Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
                Write-Success "Removed file: $($_.Name)"
            }
            $usrLibIncludePath = Join-Path $usrLibPath "include"
            if (Test-Path $usrLibIncludePath) { Remove-Item $usrLibIncludePath -Recurse -Force -ErrorAction SilentlyContinue; Write-Success "Removed: $usrLibIncludePath" }
        }
        $mainLibPath = Join-Path $excludedDir.FullName "lib"
        if (Test-Path $mainLibPath) {
            Get-ChildItem -Path $mainLibPath -Directory -Filter "erl_interface*" -ErrorAction SilentlyContinue | ForEach-Object {
                $erlInterfaceIncludePath = Join-Path $_.FullName "include"
                $erlInterfaceLibPath = Join-Path $_.FullName "lib"
                if (Test-Path $erlInterfaceIncludePath) { Remove-Item $erlInterfaceIncludePath -Recurse -Force -ErrorAction SilentlyContinue; Write-Success "Removed: $erlInterfaceIncludePath" }
                if (Test-Path $erlInterfaceLibPath) { Remove-Item $erlInterfaceLibPath -Recurse -Force -ErrorAction SilentlyContinue; Write-Success "Removed: $erlInterfaceLibPath" }
            }
        }
    }

    $cleanedDirs = 0
    Get-ChildItem -Path $BaseAddonsDir -Directory |
        Where-Object {
            $dirName = $_.Name
            $isExcluded = $false
            foreach ($pattern in $excludePatterns) { if ($dirName -like $pattern) { $isExcluded = $true; break } }
            -not $isExcluded
        } |
        ForEach-Object {
            $addonPath = $_.FullName
            $addonName = $_.Name
            Write-Stage "CLEANUP" "General cleanup for $addonName"
            [void](Remove-DirectoriesIfExists -Base $addonPath -Dirs @("include", "headers", "lib"))
            $filesRemoved = Remove-FilesByPatterns -Base $addonPath -Patterns @("*.pdb", "db2level.txt", "uidrvci.txt", "odbc_install.txt", "adrci.txt", "vc_redist.exe", "install.cmd") -Recurse
            if ($filesRemoved -gt 0) { Write-Success "Removed $filesRemoved unnecessary files" }
            $cleanedDirs++
        }

    $emptyHelpFiles = Get-ChildItem -Path "$BaseAddonsDir\*\ospanel_data\help\*" -File -ErrorAction SilentlyContinue | Where-Object { $_.Length -eq 0 }
    if ($emptyHelpFiles) {
        $emptyHelpFiles | ForEach-Object { Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue }
        Write-Success "Removed $($emptyHelpFiles.Count) empty help files"
    }
    Write-Success "Cleanup completed. Processed $cleanedDirs directories"
}

# ================== BIN/TOOLS HELPERS ==================
function Find-FileInExtracted {
    param([string]$BasePath, [string]$Pattern)
    $found = Get-ChildItem -Path $BasePath -Recurse -File -ErrorAction SilentlyContinue |
             Where-Object { $_.Name -like ($Pattern -split '\\')[-1] } |
             Select-Object -First 1
    return $found.FullName
}

function Install-ToolFromArchive {
    param([string]$Url, [string]$ExtractPath, [array]$Files, [array]$CopyFiles = @())
    $tmp = "$env:TEMP\tmpdir_$(Get-Random)"
    $zip = "$tmp.zip"
    Write-Stage "DOWNLOAD" "Downloading archive" $Url
    if (-not (Get-CachedFile -Url $Url -OutFile $zip)) {
        Write-Error "Failed to download tool archive"
        return $false
    }
    Expand-Archive $zip $tmp -Force

    foreach ($file in $Files) {
        $sourceFile = $null
        if ([string]::IsNullOrEmpty($ExtractPath)) {
            $sourceFile = "$tmp\$file"
        } else {
            $searchPaths = Get-ChildItem -Path $tmp -Directory | Where-Object { $_.Name -like ($ExtractPath -replace '\\.*$', '') }
            if ($ExtractPath.Contains('\')) {
                $subPath = $ExtractPath -replace '^[^\\]*\\', ''
                foreach ($basePath in $searchPaths) {
                    $fullPath = Join-Path $basePath.FullName $subPath
                    $testFile = Join-Path $fullPath $file
                    if (Test-Path $testFile -PathType Leaf) { $sourceFile = $testFile; break }
                }
            } else {
                foreach ($basePath in $searchPaths) {
                    $testFile = Join-Path $basePath.FullName $file
                    if (Test-Path $testFile -PathType Leaf) { $sourceFile = $testFile; break }
                }
            }
        }
        if ($sourceFile -and (Test-Path $sourceFile -PathType Leaf)) {
            Write-Stage "COPYING" "File $file"
            Copy-Item $sourceFile "$BaseBinDir\$file" -Force
            Write-Success "Copied: $sourceFile → $BaseBinDir\$file"
        } else {
            Write-Warning "File not found: $file (searched in $ExtractPath)"
        }
    }

    foreach ($copyFile in $CopyFiles) {
        if (Test-Path $copyFile -PathType Leaf) {
            $fileName = Split-Path $copyFile -Leaf
            Write-Stage "COPYING" "Additional file $fileName"
            Copy-Item $copyFile "$BaseBinDir\$fileName" -Force
            Write-Success "Copied additional file: $copyFile"
        }
    }
    Remove-Item $tmp, $zip -Recurse -Force -ErrorAction SilentlyContinue
}

function Install-DirectDownload {
    param([string]$Url, [string]$TargetName)
    Write-Stage "DOWNLOAD" "Direct downloading" $Url
    Get-CachedFile -Url $Url -OutFile "$BaseBinDir\$TargetName"
    Write-Success "File downloaded: $BaseBinDir\$TargetName"
}

function Install-FromLocalArchive {
    param([string]$LocalZip, [array]$Files)
    $tmp = "$env:TEMP\tmpdir_$(Get-Random)"
    Write-Stage "EXTRACTION" "Local archive" $LocalZip
    Expand-Archive $LocalZip $tmp -Force
    foreach ($file in $Files) {
        $sourceFile = Get-ChildItem -Path $tmp -Recurse -File | Where-Object { $_.Name -eq $file } | Select-Object -First 1
        if ($sourceFile) {
            Write-Stage "COPYING" "File $file"
            Copy-Item $sourceFile.FullName "$BaseBinDir\$file" -Force
            Write-Success "Copied: $($sourceFile.FullName) → $BaseBinDir\$file"
        } else {
            Write-Warning "File not found in archive: $file"
        }
    }
    Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
}

function Install-LocalFiles {
    param([array]$LocalFiles)
    foreach ($file in $LocalFiles) {
        if (Test-Path $file -PathType Leaf) {
            $fileName = Split-Path $file -Leaf
            Write-Stage "COPYING" "Local file $fileName"
            Copy-Item $file "$BaseBinDir\$fileName" -Force
            Write-Success "Copied local file: $file → $BaseBinDir\$fileName"
        } else {
            Write-Warning "Local file not found: $file"
        }
    }
}

function Install-PhpMyAdmin {
    param(
        [string]$DownloadUrl = "https://files.phpmyadmin.net/phpMyAdmin/5.2.3/phpMyAdmin-5.2.3-all-languages.zip",
        [string]$TargetDir   = "..\home\phpmyadmin"
    )

    try {
        Write-Stage "PHPMYADMIN" "Preparing target directory" $TargetDir
        if (-not (Test-Path $TargetDir)) {
            New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
            Write-Success "Created directory: $TargetDir"
        } else {
            Write-Success "Target directory exists: $TargetDir"
        }

        # Загружаем архив в кэш и во временный файл
        $tmpZip = Join-Path $env:TEMP ("pma_" + (Get-Random) + ".zip")
        Write-Stage "PHPMYADMIN" "Downloading archive" $DownloadUrl
        if (-not (Get-CachedFile -Url $DownloadUrl -OutFile $tmpZip)) {
            Write-Error "Failed to download phpMyAdmin archive"
            return $false
        }

        # Распаковываем во временную папку
        $tmpExtract = New-TempDir
        Write-Stage "PHPMYADMIN" "Extracting to temp" $tmpExtract
        try {
            Expand-Archive -Path $tmpZip -DestinationPath $tmpExtract -Force
        } catch {
            Write-Error "Error extracting phpMyAdmin archive: $_"
            Remove-Item $tmpZip -Force -ErrorAction SilentlyContinue
            Remove-Item $tmpExtract -Recurse -Force -ErrorAction SilentlyContinue
            return $false
        }

        # Находим корневую папку внутри архива (обычно "phpMyAdmin-5.2.2-all-languages")
        $innerDir = Get-ChildItem -Path $tmpExtract -Directory -ErrorAction SilentlyContinue | Select-Object -First 1
        if (-not $innerDir) {
            $innerDirPath = $tmpExtract
        } else {
            $innerDirPath = $innerDir.FullName
        }

        # Копируем содержимое в ..\home\phpmyadmin БЕЗ ПЕРЕЗАПИСИ СУЩЕСТВУЮЩИХ ФАЙЛОВ
        # ВАЖНО: именно без замены (если файл существует — пропускаем его).
        Write-Stage "PHPMYADMIN" "Copying files without overwrite" $TargetDir

        $copied = 0
        $skipped = 0

        # Копируем каталоги
        Get-ChildItem -Path $innerDirPath -Recurse -Force | ForEach-Object {
            $relPath = $_.FullName.Substring($innerDirPath.Length).TrimStart('\','/')
            $destPath = Join-Path $TargetDir $relPath

            if ($_.PSIsContainer) {
                if (-not (Test-Path $destPath)) {
                    New-Item -ItemType Directory -Force -Path $destPath | Out-Null
                }
                return
            }

            # Файл: если уже существует — пропускаем, иначе копируем
            if (Test-Path $destPath -PathType Leaf) {
                $skipped++
            } else {
                New-DirectoryIfNotExists -FilePath $destPath
                try {
                    Copy-Item -Path $_.FullName -Destination $destPath -Force:$false
                    $copied++
                } catch {
                    # На случай, если PowerShell всё же пытается перезаписать — перестрахуемся
                    if (-not (Test-Path $destPath)) {
                        Copy-Item -Path $_.FullName -Destination $destPath
                        $copied++
                    } else {
                        $skipped++
                    }
                }
            }
        }

        Write-Success "phpMyAdmin copied: $copied new files, skipped (already exist): $skipped"

        # Удаляем временные файлы
        Remove-Item $tmpZip -Force -ErrorAction SilentlyContinue
        Remove-Item $tmpExtract -Recurse -Force -ErrorAction SilentlyContinue

        Write-Success "phpMyAdmin installation completed"
        return $true
    } catch {
        Write-Error "phpMyAdmin installation error: $_"
        return $false
    }
}

function New-ToolHelp {
    param([array]$Command, [string]$OutputFile = $null)
    if (-not $OutputFile) { $OutputFile = "$($Command[0] -replace '\.exe$', '').txt" }
    $helpPath = "$BaseBinDir\help\$OutputFile"
    $execPath = "$BaseBinDir\$($Command[0])"
    if (-not (Test-Path $execPath -PathType Leaf)) { Write-Warning "Executable not found for help generation: $execPath"; return }
    Write-Stage "HELP" "Generating help for $($Command[0])"
    try {
        $out = & $execPath $Command[1..($Command.Length-1)] 2>&1 | Where-Object {$_.ToString().Trim()}
        $out | Out-File $helpPath -Encoding utf8 -Force
        Write-Success "Help created: $OutputFile"
    } catch { Write-Warning "Error generating help for $($Command[0]): $_" }
}

function Copy-ComposerFiles {
    Write-Host ""
    Write-Stage "COMPOSER" "Downloading Composer and keys"
    $sources = @{
        "composer.phar" = "..\resources\composer\composer.phar"
        "config.json" = "..\resources\composer\config.json"
        "composer.json" = "..\resources\composer\composer.json"
        "auth.json" = "..\resources\composer\auth.json"
        "keys.tags.pub" = "..\resources\composer\keys.tags.pub"
        "keys.dev.pub" = "..\resources\composer\keys.dev.pub"
        "composer.bat" = "..\resources\composer\composer.bat"
    }
    $sourceDir = "..\resources\composer"
    if (-not (Test-Path $sourceDir)) { New-Item -ItemType Directory -Path $sourceDir -Force | Out-Null }
    foreach ($file in @("composer.phar", "keys.tags.pub", "keys.dev.pub")) {
        $filePath = $sources[$file]
        if (Test-Path $filePath) { Remove-Item $filePath -Force -ErrorAction SilentlyContinue; Write-Success "Removed old file: $file" }
    }
    $downloads = @{
        "https://composer.github.io/snapshots.pub" = $sources["keys.dev.pub"]
        "https://composer.github.io/releases.pub"  = $sources["keys.tags.pub"]
        "https://getcomposer.org/download/latest-stable/composer.phar" = $sources["composer.phar"]
    }
    foreach ($url in $downloads.Keys) {
        $destPath = $downloads[$url]
        Write-Stage "COMPOSER" "Downloading $(Split-Path $destPath -Leaf)" $url
        try {
            if (Get-CachedFile -Url $url -OutFile $destPath) { Write-Success "Downloaded: $(Split-Path $destPath -Leaf)" }
            else { Write-Warning "Failed to download: $(Split-Path $destPath -Leaf)" }
        } catch { Write-Warning "Error downloading $(Split-Path $destPath -Leaf): $_" }
    }
    $missingFiles = @()
    foreach ($file in $sources.Keys) { if (-not (Test-Path $sources[$file])) { $missingFiles += $file } }
    if ($missingFiles.Count -gt 0) { Write-Error "Missing files: $($missingFiles -join ', ')"; return $false }
    Write-Success "All Composer files verified"

    $composerSubfolderFiles = @("composer.phar", "config.json", "composer.json", "auth.json", "keys.tags.pub", "keys.dev.pub")
    $phpRootFiles = @("composer.bat")
    $phpVersions = @("7.2", "7.3", "7.4", "8.0", "8.1", "8.2", "8.3", "8.4", "8.5")

    foreach ($version in $phpVersions) {
        $phpModuleDir = "..\modules\PHP-$version"
        $composerTargetDir = "$phpModuleDir\ospanel_data\default_data\composer"
        if (Test-Path $phpModuleDir) {
            Write-Stage "COMPOSER" "Copying files to PHP $version"
            if (Test-Path $composerTargetDir) {
                foreach ($file in $composerSubfolderFiles) {
                    $sourcePath = $sources[$file]
                    $targetPath = Join-Path $composerTargetDir $file
                    if (Test-Path $targetPath) { Remove-Item $targetPath -Force -ErrorAction SilentlyContinue }
                    try { Copy-Item $sourcePath $targetPath -Force; Write-Success "Copied $file to PHP $version composer folder" }
                    catch { Write-Warning "Error copying $file to PHP $version composer folder: $_" }
                }
            }
            foreach ($file in $phpRootFiles) {
                $sourcePath = $sources[$file]
                $targetPath = Join-Path $phpModuleDir $file
                if (Test-Path $targetPath) { Remove-Item $targetPath -Force -ErrorAction SilentlyContinue }
                try { Copy-Item $sourcePath $targetPath -Force; Write-Success "Copied $file to PHP $version root" }
                catch { Write-Warning "Error copying $file to PHP $version root: $_" }
            }
        } else {
            Write-Warning "PHP module directory not found: $phpModuleDir"
        }
    }
    Write-Success "Composer files copy operation completed"
}

function Copy-AdditionalFiles {
    Write-Host ""
    $downloads = @{
        "https://curl.se/ca/cacert.pem" = @(
            "..\system\ssl\cacert.pem",
            "..\system\bin\curl-ca-bundle.crt",
            "..\bin\curl-ca-bundle.crt"
        )
    }
    foreach ($url in $downloads.Keys) {
        foreach ($destPath in $downloads[$url]) {
            Write-Stage "ADDITIONAL" "Downloading $(Split-Path $destPath -Leaf)" $url
            New-ParentDirectory $destPath
            if (Test-Path $destPath) { Remove-Item $destPath -Force }
            try {
                if (Get-CachedFile -Url $url -OutFile $destPath) { Write-Success "Downloaded: $destPath" }
                else { Write-Warning "Failed to download: $destPath" }
            } catch { Write-Warning "Error downloading to $destPath : $_" }
        }
    }

    $binDownloads = @(
        @{ Url = "https://files.ospanel.io/dist/ospanel.exe";       Dest = "..\bin\ospanel.exe" },
        @{ Url = "https://files.ospanel.io/dist/ospanel-debug.exe"; Dest = "..\bin\ospanel-debug.exe" }
    )
    foreach ($item in $binDownloads) {
        $destPath = $item.Dest
        Write-Stage "ADDITIONAL" "Downloading $(Split-Path $destPath -Leaf)" $item.Url
        New-ParentDirectory $destPath
        if (Test-Path $destPath) { Remove-Item $destPath -Force }
        try {
            if (Get-CachedFile -Url $item.Url -OutFile $destPath) { Write-Success "Downloaded: $destPath" }
            else { Write-Warning "Failed to download: $destPath" }
        } catch { Write-Warning "Error downloading to $destPath : $_" }
    }

    $localCopies = @{
        "..\resources\dist\README.txt" = "..\user\geo\README.txt"
        "..\resources\dist\top.html" = "..\modules\Apache\error\include\top.html"
        "..\bin\bat.exe" = "..\system\bin\bat.exe"
        "..\bin\curl.exe" = "..\system\bin\curl.exe"
        "..\bin\libcurl-x64.dll" = "..\system\bin\libcurl-x64.dll"
        "..\bin\fd.exe" = "..\system\bin\fd.exe"
    }
    foreach ($sourcePath in $localCopies.Keys) {
        $destPath = $localCopies[$sourcePath]
        if (Test-Path $sourcePath) {
            Write-Stage "ADDITIONAL" "Copying local file $(Split-Path $sourcePath -Leaf)"
            New-ParentDirectory $destPath
            try { Copy-Item $sourcePath $destPath -Force; Write-Success "Copied: $sourcePath → $destPath" }
            catch { Write-Warning "Error copying $sourcePath to $destPath : $_" }
        } else {
            Write-Warning "Source file not found: $sourcePath"
        }
    }
    Write-Success "Additional files copy operation completed"
}

# ================== SUMMARY ==================
function Show-Summary {
    Write-Host ""
    Write-Host "📊 Addon processing results:" -ForegroundColor White
    Write-Host ""
    Write-Host "   Total addons:       " -NoNewline -ForegroundColor Gray; Write-Host $script:TotalAddons -ForegroundColor White
    Write-Host "   Processed:          " -NoNewline -ForegroundColor Gray; Write-Host $script:ProcessedAddons -ForegroundColor Green
    Write-Host "   Skipped:            " -NoNewline -ForegroundColor Gray; Write-Host $script:SkippedAddons -ForegroundColor Yellow
    Write-Host "   Errors:             " -NoNewline -ForegroundColor Gray; Write-Host $script:FailedAddons -ForegroundColor Red
    Write-Host ""
    $addonSuccessRate = if ($script:TotalAddons -gt 0) { [math]::Round(($script:ProcessedAddons / $script:TotalAddons) * 100, 1) } else { 0 }
    Write-Host "   Addon success rate: " -NoNewline -ForegroundColor Gray
    Write-Host "$addonSuccessRate%" -ForegroundColor $(if ($addonSuccessRate -ge 90) { "Green" } elseif ($addonSuccessRate -ge 70) { "Yellow" } else { "Red" })
    Write-Host ""
    Write-Host "🔧 Module processing results:" -ForegroundColor White
    Write-Host ""
    Write-Host "   Total modules:      " -NoNewline -ForegroundColor Gray; Write-Host $script:TotalModules -ForegroundColor White
    Write-Host "   Processed:          " -NoNewline -ForegroundColor Gray; Write-Host $script:ProcessedModules -ForegroundColor Green
    Write-Host "   Skipped:            " -NoNewline -ForegroundColor Gray; Write-Host $script:SkippedModules -ForegroundColor Yellow
    Write-Host "   Errors:             " -NoNewline -ForegroundColor Gray; Write-Host $script:FailedModules -ForegroundColor Red
    Write-Host ""
    $moduleSuccessRate = if ($script:TotalModules -gt 0) { [math]::Round(($script:ProcessedModules / $script:TotalModules) * 100, 1) } else { 0 }
    Write-Host "   Module success rate: " -NoNewline -ForegroundColor Gray
    Write-Host "$moduleSuccessRate%" -ForegroundColor $(if ($moduleSuccessRate -ge 90) { "Green" } elseif ($moduleSuccessRate -ge 70) { "Yellow" } else { "Red" })
    Write-Host ""
    Write-Host "🛠️  Utility processing results:" -ForegroundColor White
    Write-Host ""
    Write-Host "   Total utilities:    " -NoNewline -ForegroundColor Gray; Write-Host $script:TotalTools -ForegroundColor White
    Write-Host "   Installed:          " -NoNewline -ForegroundColor Gray; Write-Host $script:ProcessedTools -ForegroundColor Green
    Write-Host "   Skipped:            " -NoNewline -ForegroundColor Gray; Write-Host $script:SkippedTools -ForegroundColor Yellow
    Write-Host "   Errors:             " -NoNewline -ForegroundColor Gray; Write-Host $script:FailedTools -ForegroundColor Red
    Write-Host ""
    $toolSuccessRate = if ($script:TotalTools -gt 0) { [math]::Round(($script:ProcessedTools / $script:TotalTools) * 100, 1) } else { 0 }
    Write-Host "   Utility success rate: " -NoNewline -ForegroundColor Gray
    Write-Host "$toolSuccessRate%" -ForegroundColor $(if ($toolSuccessRate -ge 90) { "Green" } elseif ($toolSuccessRate -ge 70) { "Yellow" } else { "Red" })
    Write-Host ""
}

# ================== MODULE PROCESSING ==================
function Get-ModuleType {
    param([string]$ModuleName)
    $types = @{
        "Apache*" = "Apache"
        "Bind*" = "Bind"
        "Blackfire*" = "Blackfire"
        "Caddy*" = "Caddy"
        "Mailpit*" = "Mailpit"
        "MariaDB*" = "MariaDB"
        "Memcached*" = "Memcached"
        "MongoDB*" = "MongoDB"
        "MySQL*" = "MySQL"
        "Nginx*" = "Nginx"
        "PHP*" = "PHP"
        "PostgreSQL*" = "PostgreSQL"
        "RabbitMQ*" = "RabbitMQ"
        "Redis*" = "Redis"
        "Smtp4dev*" = "Smtp4dev"
        "Unbound*" = "Unbound"
    }
    foreach ($pattern in $types.Keys) { if ($ModuleName -like $pattern) { return $types[$pattern] } }
    return "Unknown"
}

function Install-ApacheModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "APACHE-PROCESSING" "Processing Apache module"
        if (-not (Move-FromZipSubfolder -ZipPath $ZipPath -DestDir $DestDir -Filter "Apache*")) { throw "extract failed" }
        Write-Stage "APACHE-PROCESSING" "Cleaning up unnecessary Apache files"
        $apacheMonitorPath = Join-Path $DestDir "bin\ApacheMonitor.exe"
        if (Test-Path $apacheMonitorPath) { Remove-Item $apacheMonitorPath -Force -ErrorAction SilentlyContinue; Write-Success "Removed ApacheMonitor.exe" }
        [void](Remove-DirectoriesIfExists -Base $DestDir -Dirs @("htdocs", "lib", "include", "manual", "logs"))
        $confDir = Join-Path $DestDir "conf"
        if (Test-Path $confDir) {
            Write-Stage "APACHE-PROCESSING" "Cleaning up conf directory"
            $filesToKeep = @("charset.conv", "magic", "openssl.cnf")
            $allConfFiles = Get-ChildItem -Path $confDir -File -ErrorAction SilentlyContinue
            $removedConfFiles = 0
            foreach ($file in $allConfFiles) {
                if ($file.Name -notin $filesToKeep) { Remove-Item $file.FullName -Force -ErrorAction SilentlyContinue; $removedConfFiles++ }
            }
            $confSubDirs = Get-ChildItem -Path $confDir -Directory -ErrorAction SilentlyContinue
            foreach ($subDir in $confSubDirs) { Remove-Item $subDir.FullName -Recurse -Force -ErrorAction SilentlyContinue; $removedConfFiles++ }
            if ($removedConfFiles -gt 0) { Write-Success "Cleaned up $removedConfFiles items from conf directory" }
        }
        Write-Success "Apache module processing completed"; return $true
    } catch { Write-Error "Error processing Apache module: $_"; return $false }
}

function Install-BindModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "BIND-PROCESSING" "Processing Bind module"
        Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
        Write-Stage "BIND-PROCESSING" "Cleaning up unnecessary Bind files"
        foreach ($file in @("BINDInstall.exe", "vcredist_x64.exe")) {
            $filePath = Join-Path $DestDir $file
            if (Test-Path $filePath) { Remove-Item $filePath -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: $file" }
        }
        Write-Success "Bind module processing completed"; return $true
    } catch { Write-Error "Error processing Bind module: $_"; return $false }
}

function Install-BlackfireModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "BLACKFIRE-PROCESSING" "Processing Blackfire module"
        Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
        Write-Success "Blackfire module processing completed"; return $true
    } catch { Write-Error "Error processing Blackfire module: $_"; return $false }
}

function Install-CaddyModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "CADDY-PROCESSING" "Processing Caddy module"
        Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
        Write-Success "Caddy module processing completed"; return $true
    } catch { Write-Error "Error processing Caddy module: $_"; return $false }
}

function Install-MailpitModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try { Write-Stage "MAILPIT-PROCESSING" "Processing Mailpit module"; Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force; Write-Success "Mailpit module processing completed"; return $true }
    catch { Write-Error "Error processing Mailpit module: $_"; return $false }
}

function Install-MariaDBModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "MARIADB-PROCESSING" "Processing MariaDB module"
        if (-not (Move-FromZipSubfolder -ZipPath $ZipPath -DestDir $DestDir -Filter "mariadb*")) { throw "extract failed" }
        Write-Stage "MARIADB-PROCESSING" "Cleaning up unnecessary MariaDB files"
        $libDir = Join-Path $DestDir "lib"
        if (Test-Path $libDir) { [void](Remove-FilesByPatterns -Base $libDir -Patterns @("*.lib","*.pdb")) }
        $libPluginDir = Join-Path $DestDir "lib\plugin"
        if (Test-Path $libPluginDir) { [void](Remove-FilesByPatterns -Base $libPluginDir -Patterns @("*.lib","*.pdb")) }
        $includeDir = Join-Path $DestDir "include"
        if (Test-Path $includeDir) { Remove-Item $includeDir -Recurse -Force -ErrorAction SilentlyContinue; Write-Success "Removed include directory" }
        $binDir = Join-Path $DestDir "bin"
        if (Test-Path $binDir) {
            $totalBin = (Remove-FilesByPatterns -Base $binDir -Patterns @("*.lib","*.pdb"))
            if ($totalBin -gt 0) { Write-Success "Removed $totalBin *.lib and *.pdb files from bin directory" } else { Write-Warning "No *.lib or *.pdb files found in bin directory" }
        } else { Write-Warning "Bin directory not found: $binDir" }
        Write-Success "MariaDB module processing completed"; return $true
    } catch { Write-Error "Error processing MariaDB module: $_"; return $false }
}

function Install-MemcachedModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "MEMCACHED-PROCESSING" "Processing Memcached module"
        if (-not (Move-FromZipSubfolder -ZipPath $ZipPath -DestDir $DestDir -Filter "memcached*")) { throw "extract failed" }
        Write-Stage "MEMCACHED-PROCESSING" "Cleaning up unnecessary Memcached files"
        [void](Remove-DirectoriesIfExists -Base $DestDir -Dirs @("include"))
        $binDir = Join-Path $DestDir "bin"
        if (Test-Path $binDir) { [void](Remove-FilesByPatterns -Base $binDir -Patterns @("*.lib","*.pdb")) }
        Write-Success "Memcached module processing completed"; return $true
    } catch { Write-Error "Error processing Memcached module: $_"; return $false }
}

function Install-MongoDBModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "MONGODB-PROCESSING" "Processing MongoDB module"
        if (-not (Move-FromZipSubfolder -ZipPath $ZipPath -DestDir $DestDir -Filter "mongodb*")) { throw "extract failed" }
        Write-Stage "MONGODB-PROCESSING" "Cleaning up unnecessary MongoDB files"
        $vcRedistPath = Join-Path $DestDir "bin\vc_redist.x64.exe"
        if (Test-Path $vcRedistPath) { Remove-Item $vcRedistPath -Force -ErrorAction SilentlyContinue; Write-Success "Removed vc_redist.x64.exe from bin directory" }
        $binDir = Join-Path $DestDir "bin"
        if (Test-Path $binDir) { [void](Remove-FilesByPatterns -Base $binDir -Patterns @("*.lib","*.pdb")) }
        Write-Success "MongoDB module processing completed"; return $true
    } catch { Write-Error "Error processing MongoDB module: $_"; return $false }
}

function Install-MySQLModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "MYSQL-PROCESSING" "Processing MySQL module"
        if (-not (Move-FromZipSubfolder -ZipPath $ZipPath -DestDir $DestDir -Filter "mysql*")) { throw "extract failed" }
        Write-Stage "MYSQL-PROCESSING" "Cleaning up unnecessary MySQL files"
        [void](Remove-DirectoriesIfExists -Base $DestDir -Dirs @("data", "include", "docs", "lib\plugin\debug", "lib\debug", "mysql-test"))
        foreach ($file in @("my-default.ini","bin\mysqld-debug.exe","bin\mysqltest_embedded.exe","bin\mysqltest_embedded.exe","bin\mysql_client_test_embedded.exe","bin\mysql_client_test.exe","bin\mysql_configurator.exe","lib\libmysqld.dll")) {
            $filePath = Join-Path $DestDir $file
            if (Test-Path $filePath) { Remove-Item $filePath -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: $file" }
        }
        [void](Remove-FilesByPatterns -Base $DestDir -Patterns @("*.lib","*.pdb") -Recurse)
        Write-Success "MySQL module processing completed"; return $true
    } catch { Write-Error "Error processing MySQL module: $_"; return $false }
}

function Install-NginxModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "NGINX-PROCESSING" "Processing Nginx module"
        Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
        Write-Stage "NGINX-PROCESSING" "Cleaning up unnecessary Nginx files"
        [void](Remove-DirectoriesIfExists -Base $DestDir -Dirs @("html","logs","temp"))
        $nginxConfPath = Join-Path $DestDir "conf\nginx.conf"
        if (Test-Path $nginxConfPath) { Remove-Item $nginxConfPath -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: conf\nginx.conf" }
        Write-Success "Nginx module processing completed"; return $true
    } catch { Write-Error "Error processing Nginx module: $_"; return $false }
}

function New-PHPIniFiles {
    param([string]$DestDir,[string]$PhpVersion,[string]$MatrixIniFile,[string]$CommentsIniFile)

    $matrixJson = Get-Content -Raw -Path $MatrixIniFile | ConvertFrom-Json
    $commentsJson = Get-Content -Raw -Path $CommentsIniFile | ConvertFrom-Json

    # Определяем тип файла по имени матричного файла
    $isInitFile = $MatrixIniFile -like "*matrix-init*"

    # Все файлы используют одинаковую структуру данных
    $data = $matrixJson.php_extensions_matrix.data

    # Создаем карту комментариев - теперь обе структуры одинаковые
    $commentMap = @{}
    foreach ($p in $commentsJson.PSObject.Properties) {
        $commentMap[$p.Name] = $p.Value
    }

    # Группируем данные по расширениям/группам
    $byExtension = $data | Group-Object -Property extension

    if ($isInitFile) {
        # Создаем pre-php.ini - основные настройки PHP
        $preIniPath = Join-Path $DestDir "pre-php.ini"
        $preIniLines = New-Object System.Collections.Generic.List[string]

        # Добавляем заголовок
        $preIniLines.Add("[PHP]")
        $preIniLines.Add("")

        foreach ($extGroup in $byExtension | Sort-Object Name) {
            $extName = $extGroup.Name
            $rows = @()

            foreach ($row in $extGroup.Group) {
                $param = [string]$row.parameter
                $useFlag = [bool]$row.use
                $verValueProp = $row.php_versions.PSObject.Properties | Where-Object { $_.Name -eq $PhpVersion } | Select-Object -First 1
                if ($null -eq $verValueProp) { continue }
                $valueText = if ($null -ne $verValueProp.Value) { [string]$verValueProp.Value } else { "" }
                if ($valueText -eq "(none)") { continue }
                if ($valueText -eq "(empty)") { $valueText = "" }
                $commentText = if ($commentMap.ContainsKey($param)) { [string]$commentMap[$param] } else { "" }
                $rows += [pscustomobject]@{ Parameter=$param; Value=$valueText; Comment=$commentText; IsCommented=(-not $useFlag) }
            }

            if ($rows.Count -eq 0) { continue }

            # Создаем комментированный раздел для pre-php.ini
            $separator = ";---------------------------------------"

            $preIniLines.Add($separator)
            $preIniLines.Add("; $extName")
            $preIniLines.Add($separator)
            $preIniLines.Add("")

            foreach ($r in $rows) {
                $prefix = if ($r.IsCommented) { "; " } else { "" }
                $paramWithPrefix = "{0}{1}" -f $prefix, $r.Parameter
                $paddedParam = $paramWithPrefix.PadRight(38)
                $val = ($r.Value ?? "")
                $baseLine = "{0} = {1}" -f $paddedParam, $val

                if ([string]::IsNullOrEmpty($r.Comment)) {
                    $preIniLines.Add($baseLine.TrimEnd())
                } else {
                    if ($baseLine.Length -le 62) {
                        $preIniLines.Add(("{0}  ; {1}" -f $baseLine.PadRight(62), $r.Comment).TrimEnd())
                    } else {
                        $preIniLines.Add(("{0}  ; {1}" -f $baseLine, $r.Comment).TrimEnd())
                    }
                }
            }
            $preIniLines.Add("")
        }
        Set-Content -Path $preIniPath -Encoding ASCII -Value ($preIniLines -join [Environment]::NewLine)

    } else {
        # Создаем php.ini - настройки расширений
        $phpIniPath = Join-Path $DestDir "php.ini"
        $phpIniLines = New-Object System.Collections.Generic.List[string]

        # Добавляем заголовок для расширений
        $phpIniLines.Add(";---------------------------------------")
        $phpIniLines.Add("; Extensions settings")
        $phpIniLines.Add(";---------------------------------------")
        $phpIniLines.Add("")

        foreach ($extGroup in $byExtension | Sort-Object Name) {
            $extName = $extGroup.Name
            $rows = @()

            foreach ($row in $extGroup.Group) {
                $param = [string]$row.parameter
                $useFlag = [bool]$row.use
                $verValueProp = $row.php_versions.PSObject.Properties | Where-Object { $_.Name -eq $PhpVersion } | Select-Object -First 1
                if ($null -eq $verValueProp) { continue }
                $valueText = if ($null -ne $verValueProp.Value) { [string]$verValueProp.Value } else { "" }
                if ($valueText -eq "(none)") { continue }
                if ($valueText -eq "(empty)") { $valueText = "" }
                $commentText = if ($commentMap.ContainsKey($param)) { [string]$commentMap[$param] } else { "" }
                $rows += [pscustomobject]@{ Parameter=$param; Value=$valueText; Comment=$commentText; IsCommented=(-not $useFlag) }
            }

            if ($rows.Count -eq 0) { continue }

            # Создаем раздел в квадратных скобках для php.ini
            $phpIniLines.Add("[$extName]")
            $phpIniLines.Add("")

            # Специальная обработка для ddtrace (выравнивание по знаку равенства)
            $equalPosition = if ($extName -eq "ddtrace") {
                $maxActualParamLength = 0
                foreach ($r in $rows) {
                    $prefix = if ($r.IsCommented) { "; " } else { "" }
                    $fullParamLength = $prefix.Length + $r.Parameter.Length
                    if ($fullParamLength -gt $maxActualParamLength) { $maxActualParamLength = $fullParamLength }
                }
                $maxActualParamLength
            } else { 38 }

            foreach ($r in $rows) {
                $prefix = if ($r.IsCommented) { "; " } else { "" }
                $paramWithPrefix = "{0}{1}" -f $prefix, $r.Parameter
                $paddedParam = $paramWithPrefix.PadRight($equalPosition)
                $val = ($r.Value ?? "")
                $baseLine = "{0} = {1}" -f $paddedParam, $val

                if ([string]::IsNullOrEmpty($r.Comment)) {
                    $phpIniLines.Add($baseLine.TrimEnd())
                } else {
                    if ($baseLine.Length -le 62) {
                        $phpIniLines.Add(("{0}  ; {1}" -f $baseLine.PadRight(62), $r.Comment).TrimEnd())
                    } else {
                        $phpIniLines.Add(("{0}  ; {1}" -f $baseLine, $r.Comment).TrimEnd())
                    }
                }
            }
            $phpIniLines.Add("")
        }
        Set-Content -Path $phpIniPath -Encoding ASCII -Value ($phpIniLines -join [Environment]::NewLine)
    }
}

function New-PHPExtIni {
    param([string]$DestDir,[string]$MatrixExtFile)
    $extFolder = Join-Path $DestDir "ext"
    $extIniPath = Join-Path $DestDir "ext.ini"
    if (-not (Test-Path $extFolder)) { Write-Warning "Extensions folder not found: $extFolder"; return }
    $dllFiles = Get-ChildItem -Path $extFolder -Filter "*.dll" | Select-Object -ExpandProperty Name
    $extNames = $dllFiles | ForEach-Object { ($_ -replace '^php_', '') -replace '\.dll$', '' } | Sort-Object -Unique
    $comments = @{}
    if (Test-Path $MatrixExtFile) {
        try {
            $commentsJson = Get-Content -Path $MatrixExtFile -Raw -Encoding ASCII | ConvertFrom-Json
            if ($commentsJson.PSObject.Properties['extensions']) {
                $commentsJson.extensions.PSObject.Properties | ForEach-Object { $comments[$_.Name] = $_.Value }
            }
        } catch { Write-Warning "Error loading extension comments: $_" }
    }
    $mandatoryList = @("mbstring", "openssl", "apcu", "igbinary", "msgpack", "brotli", "lz4", "lzf", "zstd", "sockets", "curl")
    $commonList = @("bz2","crypto","enchant","exif","fileinfo","ftp","gd","gd2","gettext","gmp","hrtime","imap","intl","mailparse","mcrypt","memcache","memcached","mysqli","odbc","pdo_mysql","pdo_sqlite","redis","scrypt","soap","sodium","sqlite3","timezonedb","xmlrpc","xsl","yaml","zip")
    $zendList = @("opcache","xdebug","scoutapm")
    function Format-ExtensionLine {
        param([string]$type,[string]$extension,[hashtable]$comments,[bool]$commented = $false)
        $prefix = if ($commented) { "; " } else { "" }
        $line = "$prefix$type"
        while ($line.Length -lt 39) { $line += " " }
        $line += "= $extension"
        if ($comments.ContainsKey($extension)) {
            while ($line.Length -lt 64) { $line += " " }
            $line += "; $($comments[$extension])"
        }
        return $line
    }
    $iniLines = @()
    $iniLines += ";---------------------------------------"
    $iniLines += "; Extensions"
    $iniLines += "; Do not change the order of extensions in the config!"
    $iniLines += ";---------------------------------------"
    $iniLines += ""
    if ($extNames -contains "ioncube") {
        $iniLines += Format-ExtensionLine -type "zend_extension" -extension "ioncube" -comments $comments -commented $true
        $iniLines += ""
    }
    $foundMandatory = $mandatoryList | Where-Object { $extNames -contains $_ }
    if ($foundMandatory.Count -gt 0) {
        $iniLines += "; Mandatory extensions"; $iniLines += "; Never disable these extensions!"; $iniLines += ""
        foreach ($ext in $foundMandatory) { $iniLines += (Format-ExtensionLine -type "extension" -extension $ext -comments $comments) }
        $iniLines += ""
    }
    $foundCommon = $commonList | Where-Object { $extNames -contains $_ } | Sort-Object
    if ($foundCommon.Count -gt 0) {
        $iniLines += "; Commonly used extensions"; $iniLines += ""
        foreach ($ext in $foundCommon) { $iniLines += (Format-ExtensionLine -type "extension" -extension $ext -comments $comments) }
        $iniLines += ""
    }
    $usedExtensions = $mandatoryList + $commonList + $zendList + @("ioncube")
    $foundOptional = $extNames | Where-Object { $_ -notin $usedExtensions } | Sort-Object
    if ($foundOptional.Count -gt 0) {
        $iniLines += "; Optional / commented extensions"; $iniLines += ""
        foreach ($ext in $foundOptional) { $iniLines += (Format-ExtensionLine -type "extension" -extension $ext -comments $comments -commented $true) }
        $iniLines += ""
    }
    $foundZend = $zendList | Where-Object { $extNames -contains $_ } | Sort-Object
    if ($foundZend.Count -gt 0) {
        $iniLines += "; Zend extensions"; $iniLines += ""
        foreach ($ext in $foundZend) { $commented = if ($ext -eq "opcache") { $false } else { $true } $iniLines += (Format-ExtensionLine -type "zend_extension" -extension $ext -comments $comments -commented $commented) }
    }
    Set-Content -Path $extIniPath -Value $iniLines -Encoding ASCII
}

function Merge-PHPIniFiles {
    param([string]$DestDir,[string]$PhpVersion)
    $preIni = Join-Path $DestDir 'pre-php.ini'
    $extIni = Join-Path $DestDir 'ext.ini'
    $phpIni = Join-Path $DestDir 'php.ini'
    $mergedIni = Join-Path $DestDir 'php.ini.merged'
    if ((Test-Path $preIni) -and (Test-Path $extIni) -and (Test-Path $phpIni)) {
        $content = @(
            (Get-Content $preIni),
            (Get-Content $extIni),
            "",
            (Get-Content $phpIni)
        )
        Set-Content $mergedIni -Encoding ASCII -Value $content
        Remove-Item $preIni,$extIni,$phpIni -Force -ErrorAction SilentlyContinue
        $phpExe = Join-Path $DestDir 'php.exe'
        if (Test-Path $phpExe) {
            $phpVersionOutput = (& $phpExe -v)[0] -replace '^PHP ([\d\.]+).*','$1'
            $moduleIniPath = Join-Path $DestDir 'ospanel_data\module.ini'
            if (Test-Path $moduleIniPath) {
                $contentDat = Get-Content $moduleIniPath -Raw
                $newContent = $contentDat -replace '(\bversion\s*=\s*)[\d\.]+', ('version                 = ' + $phpVersionOutput)
                Set-Content $moduleIniPath $newContent -Encoding UTF8
            }
        }
        $finalIniDir = Join-Path $DestDir 'ospanel_data\default\templates'
        if (-not (Test-Path $finalIniDir)) { New-Item -ItemType Directory -Path $finalIniDir -Force | Out-Null }
        $finalIniPath = Join-Path $finalIniDir 'php.ini'
        Move-Item $mergedIni $finalIniPath -Force
        Write-Success "PHP configuration files merged and moved to final location"
    }
}

function Install-PHPModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "PHP-PROCESSING" "Processing PHP module with additional packages"
        $phpVersion = $ModuleName -replace '^PHP-', ''
        $module = $moduleInfodata.modules.$ModuleName
        $binUrl = $module.DownloadUrl_bin
        $extUrl = $module.DownloadUrl_ext
        Write-Stage "PHP-PROCESSING" "Downloading bin package"
        $binZip = "php-bin.zip"
        if (-not (Get-CachedFile -Url $binUrl -OutFile $binZip)) { throw "Failed to download bin package" }
        Write-Stage "PHP-PROCESSING" "Downloading ext package"
        $extZip = "php-ext.zip"
        if (-not (Get-CachedFile -Url $extUrl -OutFile $extZip)) { throw "Failed to download ext package" }
        Write-Stage "PHP-PROCESSING" "Extracting bin package"
        Expand-Archive -Path $binZip -DestinationPath $DestDir -Force; Remove-Item $binZip -Force
        Write-Stage "PHP-PROCESSING" "Extracting ext package"
        Expand-Archive -Path $extZip -DestinationPath $DestDir -Force; Remove-Item $extZip -Force
        Write-Stage "PHP-PROCESSING" "Extracting main PHP package"
        Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
        Write-Stage "PHP-PROCESSING" "Copying specific files to root"
        foreach ($file in @("bin\sasl2\plugin_sasldb.dll","bin\openssl.exe","bin\tidy.exe")) {
            $sourcePath = Join-Path $DestDir $file
            if (Test-Path $sourcePath) { Copy-Item $sourcePath (Join-Path $DestDir (Split-Path $file -Leaf)) -Force; Write-Success "Copied $(Split-Path $file -Leaf) to PHP root" }
        }
        Write-Stage "PHP-PROCESSING" "Removing unnecessary directories and files"
        [void](Remove-DirectoriesIfExists -Base $DestDir -Dirs @("bin","dev","3rd-party\imagick\config","config"))
        [void](Remove-FilesByPatterns -Base $DestDir -Patterns @("*.pdb","*.lib") -Recurse)
        $removedDlls = Remove-FilesByPatterns -Base $DestDir -Patterns @("IM_MOD_*.dll","CORE_RL_*.dll","FILTER_analyze*.dll") -Recurse
        if ($removedDlls -gt 0) { Write-Success "Removed $removedDlls unnecessary DLL files" }

        Write-Stage "PHP-PROCESSING" "Creating browscap.ini"
        try {
            $browscapUrl = "https://browscap.org/stream?q=Lite_PHP_BrowsCapINI"
            $browscapPath = Join-Path $DestDir "browscap.ini"
            if (Get-CachedFile -Url $browscapUrl -OutFile $browscapPath) { Write-Success "Downloaded browscap.ini" }
        } catch { Write-Warning "Failed to download browscap.ini: $_" }

        Write-Stage "PHP-PROCESSING" "Creating phpinfo.php"
        $phpinfoPath = Join-Path $DestDir "phpinfo.php"
        Set-Content -Path $phpinfoPath -Value "<?php phpinfo() ?>" -Encoding UTF8
        Write-Success "Created phpinfo.php"

        Write-Stage "PHP-PROCESSING" "Setting up SNMP MIBs"
        $netSnmpUrls = @{
            "7.2"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.7.3/net-snmp-5.7.3.zip?viasf=1"
            "7.3"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.7.3/net-snmp-5.7.3.zip?viasf=1"
            "7.4"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.7.3/net-snmp-5.7.3.zip?viasf=1"
            "8.0"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.7.3/net-snmp-5.7.3.zip?viasf=1"
            "8.1"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.9.4/net-snmp-5.9.4.zip?viasf=1"
            "8.2"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.9.4/net-snmp-5.9.4.zip?viasf=1"
            "8.3"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.9.4/net-snmp-5.9.4.zip?viasf=1"
            "8.4"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.9.4/net-snmp-5.9.4.zip?viasf=1"
            "8.5"="https://netix.dl.sourceforge.net/project/net-snmp/net-snmp/5.9.4/net-snmp-5.9.4.zip?viasf=1"
        }
        if ($netSnmpUrls.ContainsKey($phpVersion)) {
            try {
                $snmpUrl = $netSnmpUrls[$phpVersion]
                $snmpZip = "net-snmp.zip"
                $snmpTmpDir = "$env:TEMP\netsnmp_$(Get-Random)"
                if (Get-CachedFile -Url $snmpUrl -OutFile $snmpZip) {
                    Expand-Archive -Path $snmpZip -DestinationPath $snmpTmpDir -Force
                    $mibsDestDir = Join-Path $DestDir "extras\mibs"
                    if (-not (Test-Path $mibsDestDir)) { New-Item -ItemType Directory -Force -Path $mibsDestDir | Out-Null }
                    $netSnmpDir = Get-ChildItem -Path $snmpTmpDir -Directory -Filter "net-snmp*" | Select-Object -First 1
                    if ($netSnmpDir) {
                        $mibsSourceDir = Join-Path $netSnmpDir.FullName "mibs"
                        if (Test-Path $mibsSourceDir) { Get-ChildItem -Path $mibsSourceDir -File | ForEach-Object { Copy-Item $_.FullName $mibsDestDir -Force }; Write-Success "Extracted SNMP MIBs for PHP $phpVersion" }
                    }
                    Remove-Item $snmpZip -Force -ErrorAction SilentlyContinue
                    Remove-Item $snmpTmpDir -Recurse -Force -ErrorAction SilentlyContinue
                }
            } catch { Write-Warning "Failed to setup SNMP MIBs: $_" }
        }

        Write-Stage "PHP-PROCESSING" "Generating PHP configuration files"
        $matrixInitFile = "..\resources\matrix\matrix-init.json"
        $commentsInitFile = "..\resources\matrix\matrix-init-comments.json"
        $matrixIniFile = "..\resources\matrix\matrix-ini.json"
        $commentsIniFile = "..\resources\matrix\matrix-ini-comments.json"
        $matrixExtFile = "..\resources\matrix\matrix-ext-comments.json"
        if ((Test-Path $matrixIniFile) -and (Test-Path $commentsIniFile) -and (Test-Path $matrixIniFile) -and (Test-Path $commentsIniFile)) {
            try {
                New-PHPIniFiles -DestDir $DestDir -PhpVersion $phpVersion -MatrixIniFile $matrixInitFile -CommentsIniFile $commentsInitFile
                New-PHPIniFiles -DestDir $DestDir -PhpVersion $phpVersion -MatrixIniFile $matrixIniFile -CommentsIniFile $commentsIniFile
                New-PHPExtIni -DestDir $DestDir -MatrixExtFile $matrixExtFile
                Merge-PHPIniFiles -DestDir $DestDir -PhpVersion $phpVersion
                Write-Success "Generated and merged PHP configuration files"
            } catch { Write-Warning "Failed to generate PHP configuration files: $_" }
        }
        Write-Success "PHP module processing completed"; return $true
    } catch { Write-Error "Error processing PHP module: $_"; return $false }
}

function Install-PostgreSQLModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "POSTGRESQL-PROCESSING" "Processing PostgreSQL module"
        # Feature: internal pgsql directory
        $tmpDir = New-TempDir
        Expand-Zip -ZipPath $ZipPath -DestDir $tmpDir
        $pgsqlDir = Get-ChildItem -Path $tmpDir -Directory | Where-Object { $_.Name -eq "pgsql" } | Select-Object -First 1
        if ($pgsqlDir) {
            Move-AllChildren -SourceDir $pgsqlDir.FullName -DestDir $DestDir
            Write-Success "Moved files from pgsql to module root"
        } else {
            Move-AllChildren -SourceDir $tmpDir -DestDir $DestDir
            Write-Success "Files moved directly to module root"
        }
        Remove-Item $tmpDir -Recurse -Force -ErrorAction SilentlyContinue

        Write-Stage "POSTGRESQL-PROCESSING" "Cleaning up unnecessary PostgreSQL files"
        [void](Remove-DirectoriesIfExists -Base $DestDir -Dirs @("pgAdmin 4","pgAdmin 3","include","symbols","lib\pkgconfig","lib\pgxs"))
        $libFilesCount = Remove-FilesByPatterns -Base $DestDir -Patterns @("*.lib","*.pdb") -Recurse
        $libASubDir = Join-Path $DestDir "lib"
        $libAFiles = @()
        if (Test-Path $libASubDir) { $libAFiles = @(Get-ChildItem -Path $libASubDir -Filter "lib*.a" -File -ErrorAction SilentlyContinue) }
        foreach ($file in $libAFiles) { Remove-Item $file.FullName -Force -ErrorAction SilentlyContinue }
        $totalRemoved = $libFilesCount + $libAFiles.Count
        if ($totalRemoved -gt 0) { Write-Success "Removed $totalRemoved *.lib, *.pdb and lib\lib*.a files" }

        Write-Success "PostgreSQL module processing completed"; return $true
    } catch { Write-Error "Error processing PostgreSQL module: $_"; return $false }
}

function Install-RabbitMQModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "RABBITMQ-PROCESSING" "Processing RabbitMQ module"
        if (-not (Move-FromZipSubfolder -ZipPath $ZipPath -DestDir $DestDir -Filter "rabbitmq*")) { throw "extract failed" }
        Write-Stage "RABBITMQ-PROCESSING" "Cleaning up unnecessary RabbitMQ files"
        $readmePath = Join-Path $DestDir "etc\README.txt"
        if (Test-Path $readmePath) { Remove-Item $readmePath -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: etc\README.txt" }
        Write-Success "RabbitMQ module processing completed"; return $true
    } catch { Write-Error "Error processing RabbitMQ module: $_"; return $false }
}

function Install-RedisModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "REDIS-PROCESSING" "Processing Redis module"
        if (-not (Move-FromZipSubfolder -ZipPath $ZipPath -DestDir $DestDir -Filter "redis*")) { throw "extract failed" }
        Write-Stage "REDIS-PROCESSING" "Cleaning up unnecessary Redis files"
        foreach ($file in @("redis.conf","install_redis.cmd")) {
            $filePath = Join-Path $DestDir $file
            if (Test-Path $filePath) { Remove-Item $filePath -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: $file" }
        }
        Write-Stage "REDIS-PROCESSING" "Downloading RedisJson module"
        try {
            $rejsonUrl = "https://github.com/zkteco-home/RedisJson/raw/master/rejson.dll"
            $rejsonPath = Join-Path $DestDir "rejson.dll"
            if (Get-CachedFile -Url $rejsonUrl -OutFile $rejsonPath) { Write-Success "Downloaded rejson.dll to module directory" }
        } catch { Write-Warning "Failed to download rejson.dll: $_" }
        Write-Success "Redis module processing completed"; return $true
    } catch { Write-Error "Error processing Redis module: $_"; return $false }
}

function Install-Smtp4devModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "SMTP4DEV-PROCESSING" "Processing Smtp4dev module"
        Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
        Write-Stage "SMTP4DEV-PROCESSING" "Cleaning up unnecessary Smtp4dev files"
        Remove-FilesByPatterns -Base $DestDir -Patterns @("*.pdb") -Recurse
        foreach ($file in @("web.config","appsettings.json")) {
            $filePath = Join-Path $DestDir $file
            if (Test-Path $filePath) { Remove-Item $filePath -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: $file" }
        }
        $xmlOldPath = Join-Path $DestDir "Rnwood.Smtp4dev.xml"
        if (Test-Path $xmlOldPath) { Rename-Item -Path $xmlOldPath -NewName "w3wp.Smtp4dev.exe.xml" -Force; Write-Success "Renamed Rnwood.Smtp4dev.xml to w3wp.Smtp4dev.exe.xml" }
        $exeOldPath = Join-Path $DestDir "Rnwood.Smtp4dev.exe"
        if (Test-Path $exeOldPath) { Rename-Item -Path $exeOldPath -NewName "w3wp.Smtp4dev.exe" -Force; Write-Success "Renamed Rnwood.Smtp4dev.exe to w3wp.Smtp4dev.exe" }
        Write-Success "Smtp4dev module processing completed"; return $true
    } catch { Write-Error "Error processing Smtp4dev module: $_"; return $false }
}

function Install-UnboundModule { param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "UNBOUND-PROCESSING" "Processing Unbound module"
        Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
        Write-Stage "UNBOUND-PROCESSING" "Cleaning up unnecessary Unbound files"
        foreach ($file in @("root.key","service.conf","unbound-service-install.exe","unbound-service-remove.exe")) {
            $filePath = Join-Path $DestDir $file
            if (Test-Path $filePath) { Remove-Item $filePath -Force -ErrorAction SilentlyContinue; Write-Success "Removed file: $file" }
        }
        $libunboundPath = Join-Path $DestDir "libunbound"
        if (Test-Path $libunboundPath) { Remove-Item $libunboundPath -Recurse -Force -ErrorAction SilentlyContinue; Write-Success "Removed directory: libunbound" }
        Write-Success "Unbound module processing completed"; return $true
    } catch { Write-Error "Error processing Unbound module: $_"; return $false }
}

function Expand-Module {
    param([string]$ModuleName, [string]$ZipPath, [string]$DestDir)
    try {
        Write-Stage "EXTRACTION" "Extracting module archive"
        if (-not (Test-Path $DestDir)) { New-Item -ItemType Directory -Force -Path $DestDir | Out-Null }
        $moduleType = Get-ModuleType -ModuleName $ModuleName
        $result = switch ($moduleType) {
            "Apache"      { Install-ApacheModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Bind"        { Install-BindModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Blackfire"   { Install-BlackfireModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Caddy"       { Install-CaddyModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Mailpit"     { Install-MailpitModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "MariaDB"     { Install-MariaDBModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Memcached"   { Install-MemcachedModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "MongoDB"     { Install-MongoDBModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "MySQL"       { Install-MySQLModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Nginx"       { Install-NginxModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "PHP"         { Install-PHPModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "PostgreSQL"  { Install-PostgreSQLModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "RabbitMQ"    { Install-RabbitMQModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Redis"       { Install-RedisModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Smtp4dev"    { Install-Smtp4devModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            "Unbound"     { Install-UnboundModule -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir }
            default {
                Write-Warning "Unknown module type for $ModuleName, using standard extraction"
                Expand-Archive -Path $ZipPath -DestinationPath $DestDir -Force
                $true
            }
        }
        if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
        if ($result) { Write-Success "Module archive successfully extracted and deleted" }
        return $result
    } catch { Write-Error "Error extracting module archive: $_"; return $false }
}

function New-ModuleHelpFiles {
    param([string]$ModuleName, [string]$DestDir, [object]$Module)
    Write-Stage "HELP" "Generating module help files"
    $HelpDir = "$DestDir\ospanel_data\help"
    if (-not (Test-Path $HelpDir)) { New-Item -ItemType Directory -Force -Path $HelpDir | Out-Null }
    $helpCmd = if ($Module.help) { $Module.help } else { "--help" }
    $exclude = @('logresolve.exe','nslookup.exe','isolationtester.exe','phpdbg.exe','memcached-debug.exe')

    $generatedFiles = Write-HelpForExecutables -RootDir $DestDir -HelpDir $HelpDir -DefaultHelpSwitch $helpCmd -ExcludeExeNames $exclude

    if ($ModuleName -match '^(mysql|mariadb)') {
        $perlScripts = Get-ChildItem -Path $DestDir -Recurse -Filter *.pl -ErrorAction SilentlyContinue
        foreach ($pl in $perlScripts) {
            $outFile = Join-Path $HelpDir ($pl.Name + ".txt")
            try {
                $output = & perl $pl.FullName --help 2>&1
                $filteredOutput = $output | Where-Object { $_.ToString().Trim() -ne "" }
                if ($filteredOutput) { $filteredOutput | Out-File -FilePath $outFile -Encoding utf8; $generatedFiles++ }
            } catch { Write-Warning "Error generating help for perl script $($pl.Name): $_" }
        }
        $ibd2sdi = Join-Path $DestDir "bin\ibd2sdi.exe"
        if (Test-Path $ibd2sdi) {
            try {
                $outFile = Join-Path $HelpDir "ibd2sdi.txt"
                $output = & $ibd2sdi --help 2>&1
                $filteredOutput = $output | Where-Object { $_.ToString().Trim() -ne "" }
                if ($filteredOutput) { $filteredOutput | Out-File -FilePath $outFile -Encoding utf8; $generatedFiles++ }
            } catch { Write-Warning "Error generating help for ibd2sdi.exe: $_" }
        }
        $mysqld = Join-Path $DestDir "bin\mysqld.exe"
        if (Test-Path $mysqld) {
            try {
                $outFile = Join-Path $HelpDir "mysqld.txt"
                $output = & $mysqld --verbose --help 2>&1
                $filteredOutput = $output | Where-Object { $_.ToString().Trim() -ne "" }
                if ($filteredOutput) { $filteredOutput | Out-File -FilePath $outFile -Encoding utf8; $generatedFiles++ }
            } catch { Write-Warning "Error generating help for mysqld.exe: $_" }
        }
        $mariadbd = Join-Path $DestDir "bin\mariadbd.exe"
        if (Test-Path $mariadbd) {
            try {
                $outFile = Join-Path $HelpDir "mariadbd.txt"
                $output = & $mariadbd --verbose --help 2>&1
                $filteredOutput = $output | Where-Object { $_.ToString().Trim() -ne "" }
                if ($filteredOutput) { $filteredOutput | Out-File -FilePath $outFile -Encoding utf8; $generatedFiles++ }
            } catch { Write-Warning "Error generating help for mariadbd.exe: $_" }
        }
        Write-Success "Created $generatedFiles module help files for MySQL/MariaDB"
        return
    }
    Write-Success "Created $generatedFiles module help files"
}

function New-ModuleIniFile {
    param([string]$DestDir, [object]$Module)
    Write-Stage "CONFIGURATION" "Creating module.ini"
    $IniPath = "$DestDir\ospanel_data\module.ini"
    $sectionsOrder = @("main", "docs")
    $skipSections = @("DownloadUrl", "ZipPath", "help", "DownloadUrl_bin", "DownloadUrl_ext")
    $iniContent = @()
    foreach ($sec in $sectionsOrder) {
        if ($Module.PSObject.Properties.Name -contains $sec) { $iniContent += Convert-ToIni -SectionName $sec -Data $Module.$sec; $iniContent += "" }
    }
    $otherSections = $Module.PSObject.Properties.Name |
                     Where-Object { $sectionsOrder -notcontains $_ -and $skipSections -notcontains $_ } |
                     Sort-Object
    foreach ($sec in $otherSections) { $iniContent += Convert-ToIni -SectionName $sec -Data $Module.$sec; $iniContent += "" }
    $iniDir = Split-Path $IniPath -Parent
    if (-not (Test-Path $iniDir)) { New-Item -ItemType Directory -Force -Path $iniDir | Out-Null }
    $iniContent | Out-File -FilePath $IniPath -Encoding utf8 -Force
    Write-Success "module.ini file created"
}

function Copy-ModuleBundleFiles {
    param([string]$ModuleName, [string]$DestDir)
    $bundleSrc = "..\resources\modules\$ModuleName"
    if (Test-Path $bundleSrc) {
        Write-Stage "COPYING" "Additional files from module bundle"
        try { Copy-Item -Path (Join-Path $bundleSrc "*") -Destination $DestDir -Recurse -Force; Write-Success "Additional module files copied" }
        catch { Write-Warning "Error copying additional module files: $_" }
    }
}

# ================== MAIN EXECUTION BLOCK ==================
Write-Banner "AUTOMATED OSPANEL ADDONS AND UTILITIES BUILD" "Cyan"
Write-Host ""

$folders = @("..\addons", "..\modules", "..\bin", "..\config", "..\data", "..\user\geo", $CacheDir)
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Write-Host "📂 Created directory: $folder" -ForegroundColor Green
    }
}

# STEP 1: Prerequisites Check
$script:CurrentMainStep = 1
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): PREREQUISITES CHECK" "Cyan"
Write-Host ""
if (-not (Test-Prerequisites)) { exit 1 }

# STEP 2: Addon Processing
$script:CurrentMainStep = 2
$config = Get-AddonsList
if (-not $config) { Write-Error "Failed to load addon configuration"; exit 1 }
$infodata = $config.InfoData
$addons = $config.Addons
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): PROCESSING ADDONS" "Yellow"

foreach ($AddonName in $addons) {
    $script:ProcessedAddons++
    Write-Host ""
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
    Write-Host " ADDON: $AddonName [$script:ProcessedAddons/$script:TotalAddons]" -ForegroundColor Cyan
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
    Write-Host ""
    $addon = $infodata.addons.$AddonName
    if (-not $addon.DownloadUrl) { Write-Skip "Addon '$AddonName' skipped (missing DownloadUrl)"; $script:SkippedAddons++; continue }
    $DestDir = Join-Path $BaseAddonsDir $AddonName
    if (Test-Path $DestDir) { Write-Skip "Addon '$AddonName' skipped (folder already exists)"; $script:SkippedAddons++; continue }
    $ZipPath = "addon.zip"
    try {
        if ($AddonName -eq "InstantClient") {
            $script:CurrentAddonSubStep = 1
            if (-not (Expand-Addon -AddonName $AddonName -ZipPath "" -DestDir $DestDir -DownloadUrl $addon.DownloadUrl)) { $script:FailedAddons++; continue }
        } else {
            $script:CurrentAddonSubStep = 1
            if (-not (Get-Addon -DownloadUrl $addon.DownloadUrl -ZipPath $ZipPath)) { $script:FailedAddons++; continue }
            $script:CurrentAddonSubStep = 2
            if (-not (Expand-Addon -AddonName $AddonName -ZipPath $ZipPath -DestDir $DestDir)) { $script:FailedAddons++; continue }
        }
        $script:CurrentAddonSubStep = 3
        New-HelpFiles -AddonName $AddonName -DestDir $DestDir -Addon $addon
        $script:CurrentAddonSubStep = 4
        New-IniFile -DestDir $DestDir -Addon $addon
        $script:CurrentAddonSubStep = 5
        Copy-BundleFiles -AddonName $AddonName -DestDir $DestDir
        $script:CurrentAddonSubStep = 6
        Write-Success "Addon '$AddonName' successfully processed"
        $script:CurrentAddonSubStep = 0
    } catch {
        Write-Error "Critical error processing '$AddonName': $_"
        $script:FailedAddons++
        $script:CurrentAddonSubStep = 0
    }
}

# STEP 3: Cleanup
$script:CurrentMainStep = 3
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): CLEANING UNNECESSARY FILES" "Magenta"
Remove-UnnecessaryFiles

# STEP 4: Module Processing
$script:CurrentMainStep = 4
$moduleConfig = Get-ModulesList
if (-not $moduleConfig) {
    Write-Error "Failed to load module configuration"
} else {
    $modules = $moduleConfig.Modules
    $moduleInfodata = $moduleConfig.InfoData
    Write-Host ""
    Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): PROCESSING MODULES" "Yellow"
    $BaseModulesDir = "..\modules"
    if (-not (Test-Path $BaseModulesDir)) { New-Item -ItemType Directory -Path $BaseModulesDir -Force | Out-Null }
    foreach ($ModuleName in $modules) {
        $script:ProcessedModules++
        Write-Host ""
        Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
        Write-Host " MODULE: $ModuleName [$script:ProcessedModules/$script:TotalModules]" -ForegroundColor Cyan
        Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
        Write-Host ""
        $module = $moduleInfodata.modules.$ModuleName
        if (-not $module.DownloadUrl) { Write-Skip "Module '$ModuleName' skipped (missing DownloadUrl)"; $script:SkippedModules++; continue }
        $DestDir = Join-Path $BaseModulesDir $ModuleName
        if (Test-Path $DestDir) { Write-Skip "Module '$ModuleName' skipped (folder already exists)"; $script:SkippedModules++; continue }
        $ZipPath = "module.zip"
        try {
            $ospanelDataDir = Join-Path $DestDir "ospanel_data\help"
            if (-not (Test-Path $ospanelDataDir)) { New-Item -ItemType Directory -Force -Path $ospanelDataDir | Out-Null }
            if (-not (Get-CachedFile -Url $module.DownloadUrl -OutFile $ZipPath)) { $script:FailedModules++; continue }
            if (-not (Expand-Module -ModuleName $ModuleName -ZipPath $ZipPath -DestDir $DestDir)) { $script:FailedModules++; continue }
            New-ModuleHelpFiles -ModuleName $ModuleName -DestDir $DestDir -Module $module
            Copy-ModuleBundleFiles -ModuleName $ModuleName -DestDir $DestDir
            New-ModuleIniFile -DestDir $DestDir -Module $module
            Write-Success "Module '$ModuleName' successfully processed"
        } catch {
            Write-Error "Critical error processing '$ModuleName': $_"
            $script:FailedModules++
        }
    }
}

# STEP 5: Utility Processing
$script:CurrentMainStep = 5
$binMatrix = Get-ToolsList
if (-not $binMatrix) { Write-Error "Failed to load utility configuration"; exit 1 }
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): INSTALLING SYSTEM UTILITIES" "Yellow"
if (-not (Test-Path $BaseBinDir)) { New-Item $BaseBinDir -ItemType Directory -Force | Out-Null }
$helpDir = Join-Path $BaseBinDir "help"
if (-not (Test-Path $helpDir)) { New-Item $helpDir -ItemType Directory -Force | Out-Null }

foreach ($tool in $binMatrix.tools) {
    $script:ProcessedTools++
    Write-Host ""
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
    Write-Host " UTILITY: $($tool.name) [$script:ProcessedTools/$script:TotalTools]" -ForegroundColor Cyan
    Write-Host "────────────────────────────────────────────────────────────────────────────────" -ForegroundColor Cyan
    Write-Host ""
    try {
        $script:CurrentToolSubStep = 1
        if ($tool.direct_download) {
            Install-DirectDownload -Url $tool.url -TargetName $tool.target_name
        } elseif ($tool.url -eq "local" -and $tool.local_zip) {
            Install-FromLocalArchive -LocalZip $tool.local_zip -Files $tool.files
        } elseif ($tool.url -eq "local" -and $tool.local_files) {
            Install-LocalFiles -LocalFiles $tool.local_files
        } else {
            $copyFiles = if ($tool.copy_files) { $tool.copy_files } else { @() }
            Install-ToolFromArchive -Url $tool.url -ExtractPath $tool.extract_path -Files $tool.files -CopyFiles $copyFiles
        }
        $script:CurrentToolSubStep = 2
        if ($tool.help_command) {
            New-ToolHelp -Command $tool.help_command
        } elseif ($tool.help_commands) {
            foreach ($helpCmd in $tool.help_commands) { New-ToolHelp -Command $helpCmd.command -OutputFile $helpCmd.output }
        }
        $script:CurrentToolSubStep = 3
        Write-Success "Utility '$($tool.name)' successfully installed"
        $script:CurrentToolSubStep = 0
    } catch {
        Write-Error "Critical error installing '$($tool.name)': $_"
        $script:FailedTools++
        $script:CurrentToolSubStep = 0
    }
}

# STEP 6: Composer Files
$script:CurrentMainStep = 6
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): COPYING COMPOSER FILES" "Magenta"
Copy-ComposerFiles

# STEP 7: Additional Files
$script:CurrentMainStep = 7
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): COPYING ADDITIONAL FILES" "Magenta"
Copy-AdditionalFiles

$script:CurrentMainStep = 8
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): INSTALLING PHPMYADMIN" "Magenta"
if (-not (Install-PhpMyAdmin)) {
    Write-Warning "Critical error installing phpMyAdmin"
} else {
    Write-Success "phpMyAdmin successfully installed"
}

# STEP 8: Final Statistics
$script:CurrentMainStep = 9
Write-Host ""
Write-Banner "STEP $($script:CurrentMainStep)/$($script:TotalMainSteps): FINAL STATISTICS" "Green"
Show-Summary

# Root folder. By default, one level above the script's folder. Set an explicit path if needed.
$Root = Split-Path -Parent $PSScriptRoot
# Regex: C:\Portable\Documents\Git\OSPanel\modules\ + any characters up to \bin\
$pattern = [regex]::Escape("C:\Portable\Documents\Git\OSPanel\modules\") + ".*?" + [regex]::Escape("\bin\")
$regex = New-Object System.Text.RegularExpressions.Regex($pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

$processed = 0
$changed = 0
$errors = 0

Get-ChildItem -Path $Root -Filter *.txt -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
    $file = $_.FullName
    try {
        $content = Get-Content -LiteralPath $file -Raw -ErrorAction Stop
        $newContent = $regex.Replace($content, "")
        if ($newContent -ne $content) {
            Set-Content -LiteralPath $file -Value $newContent -Encoding UTF8
            $changed++
        }
        $processed++
    } catch {
        Write-Host "Error: $file - $($_.Exception.Message)" -ForegroundColor Red
        $errors++
    }
}

Write-Banner "MANUAL UPDATE REQUIRED" "Yellow"
Write-Host ""
Write-Host "⚠️  " -ForegroundColor Yellow -NoNewline
Write-Host "The following geodata files require manual update:" -ForegroundColor White
Write-Host ""
Write-Host "📍 IP Geolocation Databases:" -ForegroundColor Cyan
Write-Host ""
Write-Host "   1. DB-IP Country Lite Database" -ForegroundColor White
Write-Host "      🌐 " -ForegroundColor Green -NoNewline
Write-Host "https://db-ip.com/db/download/ip-to-country-lite" -ForegroundColor Gray
Write-Host ""
Write-Host "   2. GeoIP Legacy Database" -ForegroundColor White
Write-Host "      🌐 " -ForegroundColor Green -NoNewline
Write-Host "https://mailfud.org/geoip-legacy/" -ForegroundColor Gray
Write-Host ""
Write-Host "   3. MaxMind GeoOpen Database (MMDB format)" -ForegroundColor White
Write-Host "      🌐 " -ForegroundColor Green -NoNewline
Write-Host "https://data.public.lu/en/datasets/geo-open-ip-address-geolocation-per-country-in-mmdb-format/" -ForegroundColor Gray
Write-Host ""
Write-Host "💡 " -ForegroundColor Blue -NoNewline
Write-Host "Please download and update these geodata files manually to ensure" -ForegroundColor White
Write-Host "   accurate IP geolocation functionality in your applications." -ForegroundColor White
Write-Host ""

Write-Banner "ADDON AND UTILITY BUILD COMPLETED" "Green"