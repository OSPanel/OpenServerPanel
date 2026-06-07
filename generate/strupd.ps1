param(
  [Parameter(Mandatory)]
  [string]$Old,

  [Parameter(Mandatory)]
  [string]$New
)

Get-ChildItem -Path . -Recurse -File -Filter 'settings.ini' | ForEach-Object {
  $p = $_.FullName

  $text = Get-Content -LiteralPath $p -Raw -Encoding UTF8
  $upd  = $text -replace [regex]::Escape($Old), $New

  [System.IO.File]::WriteAllText($p, $upd, (New-Object System.Text.UTF8Encoding($true)))
}