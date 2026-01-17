param(
    [string]$InstallPath = "C:\WSL\AlmaLinux",
    [string]$DistroName = "AlmaLinux"
)

try {
    # ディレクトリ作成
    Write-Host "インストールディレクトリを作成中..."
    New-Item -ItemType Directory -Force -Path $InstallPath | Out-Null

    # 一時ディレクトリ作成
    $tempDir = Join-Path $env:TEMP "AlmaLinux-install-$(Get-Random)"
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
    Write-Host "作業ディレクトリ: $tempDir"

    Push-Location $tempDir

    # ルートファイルシステムイメージをダウンロード
    $imageUrl = "https://wsl.almalinux.org/9/AlmaLinuxOS-9_9.3.0.0_x64.appx"
    Write-Host "AlmaLinux ルートファイルシステムをダウンロード中..."
    Invoke-WebRequest -Uri $imageUrl -OutFile "AlmaLinuxOS-9.appx" -UseBasicParsing
    
    # イメージを展開
    Write-Host "イメージを展開中..."
    Move-Item "AlmaLinuxOS-9.appx" "AlmaLinuxOS-9.zip"
    $extractPath = Join-Path $tempDir "extracted"
    New-Item -ItemType Directory -Force -Path $extractPath | Out-Null
    Expand-Archive "AlmaLinuxOS-9.zip" -DestinationPath $extractPath -Force

    Pop-Location

    # WSLをアップデート
    Write-Host "WSLを最新バージョンにアップデート中..."
    wsl --update
    # WSLにインポート
    Write-Host "WSL2にインポート中..."
    $rootfsPath = Join-Path $extractPath "install.tar.gz"
    wsl --import $DistroName $InstallPath $rootfsPath --version 2
    if ($LASTEXITCODE -ne 0) {
        throw "WSLインポートに失敗しました。終了コード: $LASTEXITCODE"
    }

    # クリーンアップ
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "インストール完了！" -ForegroundColor Green
    Write-Host "起動: wsl -d $DistroName"
}
catch {
    Write-Host "エラーが発生しました: $_" -ForegroundColor Red
    exit 1
}
