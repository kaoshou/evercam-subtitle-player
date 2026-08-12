param(
    [Parameter(Mandatory = $false)]
    [string]$OutputDirectory
)

# Project: https://github.com/kaoshou/evercam-subtitle-player
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$versionPath = Join-Path $repositoryRoot "VERSION"
$version = [System.IO.File]::ReadAllText($versionPath).Trim()

if ([string]::IsNullOrWhiteSpace($OutputDirectory)) {
    $OutputDirectory = Join-Path $repositoryRoot "release"
}

$resolvedOutputDirectory = [System.IO.Path]::GetFullPath($OutputDirectory)
if (-not (Test-Path -LiteralPath $resolvedOutputDirectory)) {
    New-Item -ItemType Directory -Path $resolvedOutputDirectory | Out-Null
}

$archiveName = "evercam-subtitle-player-v$version.zip"
$archivePath = Join-Path $resolvedOutputDirectory $archiveName
if (Test-Path -LiteralPath $archivePath) {
    Remove-Item -LiteralPath $archivePath
}

$stagingFolder = Join-Path ([System.IO.Path]::GetTempPath()) ("evercam-subtitle-player-" + [System.Guid]::NewGuid().ToString("N"))

try {
    New-Item -ItemType Directory -Path $stagingFolder | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $stagingFolder "scripts") | Out-Null

    Copy-Item -LiteralPath (Join-Path $repositoryRoot "安裝字幕播放器.cmd") -Destination $stagingFolder
    Copy-Item -LiteralPath (Join-Path $repositoryRoot "快速使用說明.txt") -Destination $stagingFolder
    Copy-Item -LiteralPath (Join-Path $repositoryRoot "商標與免責聲明.txt") -Destination $stagingFolder
    Copy-Item -LiteralPath (Join-Path $repositoryRoot "player") -Destination $stagingFolder -Recurse
    Copy-Item -LiteralPath (Join-Path $repositoryRoot "scripts\Install-Player.ps1") -Destination (Join-Path $stagingFolder "scripts")

    Compress-Archive -Path (Join-Path $stagingFolder "*") -DestinationPath $archivePath -CompressionLevel Optimal
}
finally {
    if (Test-Path -LiteralPath $stagingFolder) {
        Remove-Item -LiteralPath $stagingFolder -Recurse
    }
}

Write-Host "Release package created:"
Write-Host $archivePath
