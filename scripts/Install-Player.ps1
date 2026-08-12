<#
EverCam Subtitle Player installer
Project: https://github.com/kaoshou/evercam-subtitle-player
#>

param(
    [Parameter(Mandatory = $false)]
    [AllowEmptyString()]
    [string]$CourseFolder,

    [Parameter(Mandatory = $false)]
    [switch]$NoLaunch
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Normalize-CourseFolderInput {
    param([AllowEmptyString()][string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return ""
    }
    return $Value.Trim().Trim('"')
}

function Get-MissingCourseFiles {
    param([string]$Folder)

    return @(
        @("media.mp4", "config.js") | Where-Object {
            -not [System.IO.File]::Exists([System.IO.Path]::Combine($Folder, $_))
        }
    )
}

function Select-CourseFolder {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $githubUrl = "https://github.com/kaoshou/evercam-subtitle-player"
    $colorTeal = [System.Drawing.Color]::FromArgb(23, 106, 109)
    $colorTealDark = [System.Drawing.Color]::FromArgb(16, 76, 79)
    $colorPage = [System.Drawing.Color]::FromArgb(244, 247, 247)
    $colorInk = [System.Drawing.Color]::FromArgb(35, 39, 42)
    $colorMuted = [System.Drawing.Color]::FromArgb(99, 107, 111)
    $colorLine = [System.Drawing.Color]::FromArgb(215, 222, 223)
    $colorSuccess = [System.Drawing.Color]::FromArgb(33, 122, 77)
    $colorSuccessBack = [System.Drawing.Color]::FromArgb(232, 246, 238)
    $colorWarning = [System.Drawing.Color]::FromArgb(176, 103, 25)
    $colorWarningBack = [System.Drawing.Color]::FromArgb(255, 245, 228)
    $colorError = [System.Drawing.Color]::FromArgb(177, 52, 52)
    $colorErrorBack = [System.Drawing.Color]::FromArgb(253, 237, 237)

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "EverCam Subtitle Player - 安裝精靈"
    $form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    $form.ClientSize = New-Object System.Drawing.Size(840, 590)
    $form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi
    $form.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10)
    $form.BackColor = $colorPage

    $headerPanel = New-Object System.Windows.Forms.Panel
    $headerPanel.Location = New-Object System.Drawing.Point(0, 0)
    $headerPanel.Size = New-Object System.Drawing.Size(840, 100)
    $headerPanel.BackColor = $colorTealDark

    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Location = New-Object System.Drawing.Point(28, 18)
    $titleLabel.Size = New-Object System.Drawing.Size(780, 34)
    $titleLabel.ForeColor = [System.Drawing.Color]::White
    $titleLabel.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 18, [System.Drawing.FontStyle]::Bold)
    $titleLabel.Text = "安裝 EverCam 字幕播放器"

    $subtitleLabel = New-Object System.Windows.Forms.Label
    $subtitleLabel.Location = New-Object System.Drawing.Point(30, 58)
    $subtitleLabel.Size = New-Object System.Drawing.Size(770, 24)
    $subtitleLabel.ForeColor = [System.Drawing.Color]::FromArgb(210, 235, 235)
    $subtitleLabel.Text = "依照下列 3 個步驟，即可讓匯出的課程支援 SRT／VTT 字幕。"
    $headerPanel.Controls.AddRange(@($titleLabel, $subtitleLabel))

    $step1Badge = New-Object System.Windows.Forms.Label
    $step1Badge.Location = New-Object System.Drawing.Point(28, 122)
    $step1Badge.Size = New-Object System.Drawing.Size(34, 34)
    $step1Badge.BackColor = $colorTeal
    $step1Badge.ForeColor = [System.Drawing.Color]::White
    $step1Badge.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 11, [System.Drawing.FontStyle]::Bold)
    $step1Badge.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $step1Badge.Text = "1"

    $step1Title = New-Object System.Windows.Forms.Label
    $step1Title.Location = New-Object System.Drawing.Point(78, 118)
    $step1Title.Size = New-Object System.Drawing.Size(720, 26)
    $step1Title.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 11, [System.Drawing.FontStyle]::Bold)
    $step1Title.ForeColor = $colorInk
    $step1Title.Text = "準備字幕檔"

    $step1Description = New-Object System.Windows.Forms.Label
    $step1Description.Location = New-Object System.Drawing.Point(78, 147)
    $step1Description.Size = New-Object System.Drawing.Size(720, 42)
    $step1Description.ForeColor = $colorMuted
    $step1Description.Text = "先把 subtitle.zh-TW.srt（或其他語言的 SRT／VTT）放到與 media.mp4 相同的課程資料夾。"

    $step2Badge = New-Object System.Windows.Forms.Label
    $step2Badge.Location = New-Object System.Drawing.Point(28, 203)
    $step2Badge.Size = New-Object System.Drawing.Size(34, 34)
    $step2Badge.BackColor = $colorTeal
    $step2Badge.ForeColor = [System.Drawing.Color]::White
    $step2Badge.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 11, [System.Drawing.FontStyle]::Bold)
    $step2Badge.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $step2Badge.Text = "2"

    $step2Title = New-Object System.Windows.Forms.Label
    $step2Title.Location = New-Object System.Drawing.Point(78, 199)
    $step2Title.Size = New-Object System.Drawing.Size(720, 26)
    $step2Title.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 11, [System.Drawing.FontStyle]::Bold)
    $step2Title.ForeColor = $colorInk
    $step2Title.Text = "選擇 EverCam 課程資料夾"

    $step2Description = New-Object System.Windows.Forms.Label
    $step2Description.Location = New-Object System.Drawing.Point(78, 226)
    $step2Description.Size = New-Object System.Drawing.Size(720, 24)
    $step2Description.ForeColor = $colorMuted
    $step2Description.Text = "請貼上完整路徑，或按「瀏覽資料夾」選擇；正確的資料夾內應有 media.mp4 與 config.js。"

    $pathBox = New-Object System.Windows.Forms.TextBox
    $pathBox.Location = New-Object System.Drawing.Point(78, 258)
    $pathBox.Size = New-Object System.Drawing.Size(548, 30)
    $pathBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $pathBox.AutoCompleteMode = [System.Windows.Forms.AutoCompleteMode]::SuggestAppend
    $pathBox.AutoCompleteSource = [System.Windows.Forms.AutoCompleteSource]::FileSystemDirectories
    $pathBox.TabIndex = 0

    $pasteButton = New-Object System.Windows.Forms.Button
    $pasteButton.Location = New-Object System.Drawing.Point(642, 253)
    $pasteButton.Size = New-Object System.Drawing.Size(156, 40)
    $pasteButton.Text = "貼上路徑"
    $pasteButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $pasteButton.FlatAppearance.BorderColor = $colorTeal
    $pasteButton.ForeColor = $colorTealDark
    $pasteButton.BackColor = [System.Drawing.Color]::White
    $pasteButton.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10, [System.Drawing.FontStyle]::Bold)
    $pasteButton.TabIndex = 1
    $pasteButton.Add_Click({
        if ([System.Windows.Forms.Clipboard]::ContainsText()) {
            $pathBox.Text = Normalize-CourseFolderInput ([System.Windows.Forms.Clipboard]::GetText())
            $pathBox.SelectionStart = $pathBox.Text.Length
        }
        else {
            [System.Windows.Forms.MessageBox]::Show(
                $form,
                "剪貼簿內沒有可貼上的路徑。請先在檔案總管複製課程資料夾路徑。",
                "尚未複製路徑",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            ) | Out-Null
        }
    })

    $browseButton = New-Object System.Windows.Forms.Button
    $browseButton.Location = New-Object System.Drawing.Point(78, 304)
    $browseButton.Size = New-Object System.Drawing.Size(156, 38)
    $browseButton.Text = "瀏覽資料夾…"
    $browseButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $browseButton.FlatAppearance.BorderColor = $colorLine
    $browseButton.ForeColor = $colorInk
    $browseButton.BackColor = [System.Drawing.Color]::White
    $browseButton.TabIndex = 2
    $browseButton.Add_Click({
        $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
        $dialog.Description = "請選擇 EverCam 匯出的課程資料夾"
        $dialog.ShowNewFolderButton = $false
        $currentPath = Normalize-CourseFolderInput $pathBox.Text
        if ([System.IO.Directory]::Exists($currentPath)) {
            $dialog.SelectedPath = $currentPath
        }
        if ($dialog.ShowDialog($form) -eq [System.Windows.Forms.DialogResult]::OK) {
            $pathBox.Text = $dialog.SelectedPath
            $pathBox.SelectionStart = $pathBox.Text.Length
        }
        $dialog.Dispose()
    })

    $hint = New-Object System.Windows.Forms.Label
    $hint.Location = New-Object System.Drawing.Point(250, 311)
    $hint.Size = New-Object System.Drawing.Size(548, 24)
    $hint.ForeColor = $colorMuted
    $hint.Text = "快速方式：在檔案總管按 Ctrl+L、Ctrl+C，再回來按「貼上路徑」。"

    $statusPanel = New-Object System.Windows.Forms.Panel
    $statusPanel.Location = New-Object System.Drawing.Point(78, 354)
    $statusPanel.Size = New-Object System.Drawing.Size(720, 56)
    $statusPanel.BackColor = [System.Drawing.Color]::FromArgb(238, 242, 242)
    $statusPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle

    $statusIcon = New-Object System.Windows.Forms.Label
    $statusIcon.Location = New-Object System.Drawing.Point(15, 14)
    $statusIcon.Size = New-Object System.Drawing.Size(26, 26)
    $statusIcon.Font = New-Object System.Drawing.Font("Segoe UI Symbol", 13, [System.Drawing.FontStyle]::Bold)
    $statusIcon.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $statusIcon.ForeColor = $colorMuted
    $statusIcon.Text = "●"

    $statusLabel = New-Object System.Windows.Forms.Label
    $statusLabel.Location = New-Object System.Drawing.Point(48, 10)
    $statusLabel.Size = New-Object System.Drawing.Size(650, 34)
    $statusLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $statusLabel.ForeColor = $colorMuted
    $statusLabel.Text = "尚未選擇課程資料夾。"
    $statusPanel.Controls.AddRange(@($statusIcon, $statusLabel))

    $step3Badge = New-Object System.Windows.Forms.Label
    $step3Badge.Location = New-Object System.Drawing.Point(28, 431)
    $step3Badge.Size = New-Object System.Drawing.Size(34, 34)
    $step3Badge.BackColor = $colorTeal
    $step3Badge.ForeColor = [System.Drawing.Color]::White
    $step3Badge.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 11, [System.Drawing.FontStyle]::Bold)
    $step3Badge.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $step3Badge.Text = "3"

    $step3Title = New-Object System.Windows.Forms.Label
    $step3Title.Location = New-Object System.Drawing.Point(78, 427)
    $step3Title.Size = New-Object System.Drawing.Size(720, 26)
    $step3Title.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 11, [System.Drawing.FontStyle]::Bold)
    $step3Title.ForeColor = $colorInk
    $step3Title.Text = "開始安裝"

    $step3Description = New-Object System.Windows.Forms.Label
    $step3Description.Location = New-Object System.Drawing.Point(78, 456)
    $step3Description.Size = New-Object System.Drawing.Size(720, 24)
    $step3Description.ForeColor = $colorMuted
    $step3Description.Text = "顯示「可以安裝」後按下按鈕；工具會備份原首頁、安裝播放器並建立字幕資料。"

    $footerLine = New-Object System.Windows.Forms.Panel
    $footerLine.Location = New-Object System.Drawing.Point(28, 495)
    $footerLine.Size = New-Object System.Drawing.Size(770, 1)
    $footerLine.BackColor = $colorLine

    $githubLabel = New-Object System.Windows.Forms.Label
    $githubLabel.Location = New-Object System.Drawing.Point(28, 528)
    $githubLabel.Size = New-Object System.Drawing.Size(75, 24)
    $githubLabel.ForeColor = $colorMuted
    $githubLabel.Text = "專案說明："

    $githubLink = New-Object System.Windows.Forms.LinkLabel
    $githubLink.Location = New-Object System.Drawing.Point(104, 528)
    $githubLink.Size = New-Object System.Drawing.Size(330, 24)
    $githubLink.LinkColor = $colorTeal
    $githubLink.ActiveLinkColor = $colorTealDark
    $githubLink.Text = "github.com/kaoshou/evercam-subtitle-player"
    [void]$githubLink.Links.Add(0, $githubLink.Text.Length, $githubUrl)
    $githubLink.Add_LinkClicked({
        param($sender, $eventArgs)
        Start-Process -FilePath ([string]$eventArgs.Link.LinkData)
    })

    $installButton = New-Object System.Windows.Forms.Button
    $installButton.Location = New-Object System.Drawing.Point(540, 520)
    $installButton.Size = New-Object System.Drawing.Size(124, 44)
    $installButton.Text = "開始安裝"
    $installButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $installButton.FlatAppearance.BorderSize = 0
    $installButton.BackColor = $colorTeal
    $installButton.ForeColor = [System.Drawing.Color]::White
    $installButton.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10, [System.Drawing.FontStyle]::Bold)
    $installButton.Enabled = $false
    $installButton.TabIndex = 3

    $updatePathStatus = {
        $candidate = Normalize-CourseFolderInput $pathBox.Text
        $installButton.Enabled = $false

        if ([string]::IsNullOrWhiteSpace($candidate)) {
            $statusPanel.BackColor = [System.Drawing.Color]::FromArgb(238, 242, 242)
            $statusIcon.ForeColor = $colorMuted
            $statusLabel.ForeColor = $colorMuted
            $statusLabel.Text = "尚未選擇課程資料夾。"
            return
        }
        if (-not [System.IO.Directory]::Exists($candidate)) {
            $statusPanel.BackColor = $colorErrorBack
            $statusIcon.ForeColor = $colorError
            $statusLabel.ForeColor = $colorError
            $statusLabel.Text = "找不到這個資料夾，請檢查路徑或重新選擇。"
            return
        }

        $missing = @(Get-MissingCourseFiles $candidate)
        if ($missing.Count -gt 0) {
            $statusPanel.BackColor = $colorWarningBack
            $statusIcon.ForeColor = $colorWarning
            $statusLabel.ForeColor = $colorWarning
            $statusLabel.Text = "資料夾存在，但缺少：$($missing -join ', ')"
            return
        }

        $statusPanel.BackColor = $colorSuccessBack
        $statusIcon.ForeColor = $colorSuccess
        $statusLabel.ForeColor = $colorSuccess
        $statusLabel.Text = "可以安裝：已找到 media.mp4 與 config.js。"
        $installButton.Enabled = $true
    }

    $pathBox.Add_TextChanged({ & $updatePathStatus })
    $installButton.Add_Click({
        & $updatePathStatus
        if (-not $installButton.Enabled) {
            $pathBox.Focus()
            return
        }
        $candidate = Normalize-CourseFolderInput $pathBox.Text
        $form.Tag = $candidate
        $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Close()
    })

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Location = New-Object System.Drawing.Point(674, 520)
    $cancelButton.Size = New-Object System.Drawing.Size(124, 44)
    $cancelButton.Text = "取消"
    $cancelButton.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $cancelButton.FlatAppearance.BorderColor = $colorLine
    $cancelButton.BackColor = [System.Drawing.Color]::White
    $cancelButton.ForeColor = $colorInk
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $cancelButton.TabIndex = 4

    $form.Controls.AddRange(@(
        $headerPanel,
        $step1Badge,
        $step1Title,
        $step1Description,
        $step2Badge,
        $step2Title,
        $step2Description,
        $pathBox,
        $pasteButton,
        $browseButton,
        $hint,
        $statusPanel,
        $step3Badge,
        $step3Title,
        $step3Description,
        $footerLine,
        $githubLabel,
        $githubLink,
        $installButton,
        $cancelButton
    ))
    $form.AcceptButton = $installButton
    $form.CancelButton = $cancelButton
    $form.Add_Shown({ $pathBox.Focus() })

    $result = $form.ShowDialog()
    $selectedPath = if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        [string]$form.Tag
    }
    else {
        $null
    }
    $form.Dispose()

    if ([string]::IsNullOrWhiteSpace($selectedPath)) {
        return $null
    }
    return $selectedPath
}

$usedInteractiveSelector = $false

try {
    if ([string]::IsNullOrWhiteSpace($CourseFolder)) {
        $usedInteractiveSelector = $true
        $CourseFolder = Select-CourseFolder
        if ([string]::IsNullOrWhiteSpace($CourseFolder)) {
            Write-Host "已取消安裝。"
            exit 2
        }
    }

    $CourseFolder = Normalize-CourseFolderInput $CourseFolder
    $resolvedCourseFolder = [System.IO.Path]::GetFullPath($CourseFolder)
    if (-not [System.IO.Directory]::Exists($resolvedCourseFolder)) {
        throw "找不到課程資料夾：$resolvedCourseFolder"
    }

    $missingFiles = @(Get-MissingCourseFiles $resolvedCourseFolder)
    if ($missingFiles.Count -gt 0) {
        throw "這不是有效的 EverCam 課程資料夾，缺少：$($missingFiles -join ', ')"
    }

    $repositoryRoot = Split-Path -Parent $PSScriptRoot
    $playerFolder = Join-Path $repositoryRoot "player"
    if (-not [System.IO.Directory]::Exists($playerFolder)) {
        throw "安裝套件不完整，找不到 player 資料夾。"
    }

    $destinationIndex = Join-Path $resolvedCourseFolder "index.html"
    $backupIndex = Join-Path $resolvedCourseFolder "index.evercam-original.html"
    if ([System.IO.File]::Exists($destinationIndex) -and -not [System.IO.File]::Exists($backupIndex)) {
        $currentIndex = [System.IO.File]::ReadAllText($destinationIndex)
        if ($currentIndex -notmatch "evercam-modern\.js") {
            [System.IO.File]::Copy($destinationIndex, $backupIndex, $false)
            Write-Host "已備份原始首頁：index.evercam-original.html"
        }
    }

    Get-ChildItem -LiteralPath $playerFolder -Recurse -File | ForEach-Object {
        $relativePath = $_.FullName.Substring($playerFolder.Length).TrimStart('\', '/')
        $destinationPath = Join-Path $resolvedCourseFolder $relativePath
        $destinationDirectory = Split-Path -Parent $destinationPath
        if (-not [System.IO.Directory]::Exists($destinationDirectory)) {
            [System.IO.Directory]::CreateDirectory($destinationDirectory) | Out-Null
        }
        [System.IO.File]::Copy($_.FullName, $destinationPath, $true)
    }

    $subtitleBuilder = Join-Path $resolvedCourseFolder "tools\Build-Subtitles.ps1"
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $subtitleBuilder -CourseFolder $resolvedCourseFolder
    if ($LASTEXITCODE -ne 0) {
        throw "字幕資料產生失敗。"
    }

    Write-Host "EverCam 字幕播放器（非官方）安裝完成。"
    if ($usedInteractiveSelector) {
        [System.Windows.Forms.MessageBox]::Show(
            "播放器與字幕資料已更新完成。`r`n`r`n按「確定」後將開啟課程首頁。",
            "安裝完成",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        ) | Out-Null
    }
    if (-not $NoLaunch) {
        Start-Process -FilePath $destinationIndex
    }
}
catch {
    if ($usedInteractiveSelector) {
        [System.Windows.Forms.MessageBox]::Show(
            "安裝未完成：`r`n$($_.Exception.Message)",
            "安裝失敗",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        ) | Out-Null
    }
    Write-Error $_.Exception.Message
    exit 1
}
