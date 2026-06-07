<#
    Update-MyIni.ps1
    Назначение:
      - Найти во всех подпапках файлы my.ini и my_configured.ini
      - Установить с выравниванием (= в 25-й колонке):
          thread_cache_size       = 8
          max_heap_table_size     = 256M
          tmp_table_size          = 256M
      - Удалить параметр max_allowed_packet
      - (Опция) Прервать работу после первого изменённого файла: -StopAfterFirst

    Пример:
      .\Update-MyIni.ps1 -Path "C:\data" -StopAfterFirst
      .\Update-MyIni.ps1 -Path "C:\data"
#>

[CmdletBinding()]
param(
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [string]$Path = ".",

    # Прервать после первого изменённого файла (для теста)
    [switch]$StopAfterFirst
)

# Колонка, в которой должен стоять символ "=" (1-based)
$AlignEqualsColumn = 25

function Format-ParamLine {
    param(
        [string]$Name,
        [string]$Value,
        [int]$Align = $AlignEqualsColumn
    )
    $spaces = [Math]::Max(1, $Align - $Name.Length - 1) # -1 потому что "=" займет колонку Align
    return $Name + (' ' * $spaces) + '= ' + $Value
}

function Set-Or-AddParam {
    param(
        [string]$Content,
        [string]$Name,
        [string]$Value
    )
    $pattern = "^[ \t]*$([Regex]::Escape($Name))[ \t]*=.*?$"
    $formatted = Format-ParamLine -Name $Name -Value $Value

    if ([regex]::IsMatch($Content, $pattern, 'IgnoreCase,Multiline')) {
        return [regex]::Replace(
            $Content,
            $pattern,
            $formatted,
            'IgnoreCase,Multiline'
        )
    } else {
        $trimmed = $Content.TrimEnd("`r","`n")
        return $trimmed + "`r`n" + $formatted + "`r`n"
    }
}

$files = Get-ChildItem -Path $Path -Recurse -File -Include 'my.ini','my_configured.ini'

if (-not $files) {
    Write-Host "Файлы my.ini / my_configured.ini не найдены по пути: $Path"
    return
}

foreach ($file in $files) {
    $original = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    $modified = $original

    # Удаляем max_allowed_packet (строка целиком)
    $modified = [regex]::Replace(
        $modified,
        '^[ \t]*max_allowed_packet[ \t]*=.*?(?:\r?\n|$)',
        '',
        'IgnoreCase,Multiline'
    )

    # Устанавливаем нужные значения с выравниванием
    $modified = Set-Or-AddParam -Content $modified -Name 'max_heap_table_size' -Value '256M'
    $modified = Set-Or-AddParam -Content $modified -Name 'tmp_table_size'      -Value '256M'
    $modified = Set-Or-AddParam -Content $modified -Name 'thread_cache_size'   -Value '8'

    if ($modified -ne $original) {
        Set-Content -LiteralPath $file.FullName -Value $modified -Encoding UTF8
        Write-Host "Обновлён: $($file.FullName)"
        if ($StopAfterFirst) {
            Write-Host "Прерывание по -StopAfterFirst после первого изменённого файла."
            break
        }
    } else {
        Write-Host "Без изменений: $($file.FullName)"
    }
}