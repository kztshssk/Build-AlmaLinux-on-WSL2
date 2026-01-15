# WSL2 AlmaLinux インストールガイド

## 前提条件
- Windows 11 with WSL2有効
- 管理者権限のPowerShell

## インストール手順

### 1. PowerShellスクリプト実行（管理者）
```powershell
cd d:\build-AlmaLinux-on-WSL2
.\install-almalinux.ps1
```

### 2. WSL内でセットアップ実行
```bash
wsl -d AlmaLinux -u root bash /mnt/d/build-AlmaLinux-on-WSL2/setup-almalinux.sh
```

### 3. 起動確認
```powershell
wsl -d AlmaLinux
```

## オプション
- InstallPath: インストール先を変更（デフォルト: C:\WSL\AlmaLinux）
- DistroName: WSL ディストロ名を変更（デフォルト: AlmaLinux）

```powershell
.\install-almalinux.ps1 -InstallPath "D:\MyWSL" -DistroName "MyAlmaLinux"
```
