# Set Policies to make Edge more suitable for server use
$EdgePolicyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge'
if (-not (Test-Path $EdgePolicyPath)) { New-Item -Path $EdgePolicyPath -Force | Out-Null }

# Allow feature recommendations and browser assistance notifications > Disabled
Set-ItemProperty -Path $EdgePolicyPath -Name 'ShowRecommendationsEnabled' -Type DWord -Value 0
Set-ItemProperty -Path $EdgePolicyPath -Name 'AutoImportAtFirstRun' -Type DWord -Value 4
Set-ItemProperty -Path $EdgePolicyPath -Name 'BrowserSignin' -Type DWord -Value 0
Set-ItemProperty -Path $EdgePolicyPath -Name 'BackgroundModeEnabled' -Type DWord -Value 0
Set-ItemProperty -Path $EdgePolicyPath -Name 'ExperimentationAndConfigurationServiceControl' -Type DWord -Value 0
Set-ItemProperty -Path $EdgePolicyPath -Name 'SyncDisabled' -Type DWord -Value 1
Set-ItemProperty -Path $EdgePolicyPath -Name 'NetworkPredictionOptions' -Type DWord -Value 2
Set-ItemProperty -Path $EdgePolicyPath -Name 'HideFirstRunExperience' -Type DWord -Value 1
Set-ItemProperty -Path $EdgePolicyPath -Name 'HideInternetExplorerRedirectUXForIncompatibleSitesEnabled' -Type DWord -Value 1
Set-ItemProperty -Path $EdgePolicyPath -Name 'StartupBoostEnabled' -Type DWord -Value 0
Set-ItemProperty -Path $EdgePolicyPath -Name 'RestoreOnStartup' -Type DWord -Value 5
Set-ItemProperty -Path $EdgePolicyPath -Name 'NewTabPageContentEnabled' -Type DWord -Value 0
Set-ItemProperty -Path $EdgePolicyPath -Name 'NewTabPageLocation' -Type String -Value 'about:blank'


# Disable Server Manager pop-up at logon and launch
if (-not (Test-Path 'HKLM:\SOFTWARE\Microsoft\ServerManager')) {
    New-Item -Path 'HKLM:\SOFTWARE\Microsoft\ServerManager' | Out-Null
}
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\ServerManager' -Name 'DoNotPopWACConsoleAtSMLaunch' -Value 1 -Type DWord

if (-not (Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager')) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager' -Force | Out-Null
}
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager' -Name 'DoNotOpenAtLogon' -Value 1 -Type DWord

# Install Evergreen and Notpad++
if (Get-PSRepository | Where-Object { $_.Name -eq "PSGallery" -and $_.InstallationPolicy -ne "Trusted" }) {
    Install-PackageProvider -Name "NuGet" -MinimumVersion 2.8.5.208 -Force
    Set-PSRepository -Name "PSGallery" -InstallationPolicy "Trusted"
}

Install-Module -Name Evergreen
Import-Module -Name Evergreen


Get-EvergreenApp -Name "NotepadPlusPlus"

$Npp = Get-EvergreenApp -Name NotepadPlusPlus | Where-Object { $_.Architecture -eq "x64" -and $_.InstallerType -eq "Default" }
$NppInstaller = Split-Path -Path $Npp.Uri -Leaf
$InstallerPath = $Env:TEMP + "\" + $NppInstaller
Invoke-WebRequest -Uri $Npp.Uri -OutFile $InstallerPath -UseBasicParsing

Start-Process -FilePath $InstallerPath -ArgumentList "/S" -Wait