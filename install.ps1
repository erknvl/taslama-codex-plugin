$ErrorActionPreference = 'Stop'

$archiveUrl = 'https://github.com/erknvl/taslama-codex-plugin/archive/refs/heads/main.zip'
$installRoot = Join-Path $env:LOCALAPPDATA 'Taslama'
$marketplaceDir = Join-Path $installRoot 'codex-marketplace'
$temporaryDir = Join-Path ([System.IO.Path]::GetTempPath()) ("taslama-" + [guid]::NewGuid())
$archivePath = Join-Path $temporaryDir 'taslama-marketplace.zip'
$extractedDir = Join-Path $temporaryDir 'taslama-codex-plugin-main'

$codexCommand = Get-Command codex.exe -ErrorAction SilentlyContinue
if (-not $codexCommand) {
    $codexCommand = Get-Command codex -ErrorAction SilentlyContinue
}
if (-not $codexCommand) {
    throw 'Codex was not found. Install or update Codex, ensure codex is on PATH, then run this script again.'
}
$codex = $codexCommand.Source

try {
    New-Item -ItemType Directory -Force -Path $temporaryDir | Out-Null

    Write-Host 'Downloading the Taslama marketplace...'
    Invoke-WebRequest -UseBasicParsing -Uri $archiveUrl -OutFile $archivePath
    Expand-Archive -LiteralPath $archivePath -DestinationPath $temporaryDir -Force

    $manifest = Join-Path $extractedDir '.agents\plugins\marketplace.json'
    if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
        throw 'The downloaded archive is not a valid Taslama marketplace.'
    }

    New-Item -ItemType Directory -Force -Path $installRoot | Out-Null
    if (Test-Path -LiteralPath $marketplaceDir) {
        Remove-Item -LiteralPath $marketplaceDir -Recurse -Force
    }
    Move-Item -LiteralPath $extractedDir -Destination $marketplaceDir

    $plugins = & $codex plugin list --json 2>$null | ConvertFrom-Json
    if ($plugins.installed | Where-Object { $_.pluginId -eq 'taslama@taslama' }) {
        & $codex plugin remove 'taslama@taslama' | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'Could not replace the existing Taslama plugin.' }
    }

    $marketplaces = & $codex plugin marketplace list --json 2>$null | ConvertFrom-Json
    if ($marketplaces.marketplaces | Where-Object { $_.name -eq 'taslama' }) {
        & $codex plugin marketplace remove taslama | Out-Null
        if ($LASTEXITCODE -ne 0) { throw 'Could not replace the existing Taslama marketplace.' }
    }

    & $codex plugin marketplace add $marketplaceDir
    if ($LASTEXITCODE -ne 0) { throw 'Could not register the Taslama marketplace.' }

    & $codex plugin add 'taslama@taslama'
    if ($LASTEXITCODE -ne 0) { throw 'Could not install the Taslama plugin.' }

    Write-Host 'Opening Taslama authorization...'
    & $codex mcp login taslama --oauth-client-registration dcr
    if ($LASTEXITCODE -ne 0) { throw 'Taslama was installed, but authorization did not complete.' }

    Write-Host 'Taslama is installed and connected. Restart ChatGPT/Codex and open a new task.'
}
finally {
    if (Test-Path -LiteralPath $temporaryDir) {
        Remove-Item -LiteralPath $temporaryDir -Recurse -Force
    }
}
