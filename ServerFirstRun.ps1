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



# Create key and set DoNotPopWACConsoleAtSMLaunch
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\ServerManager' -Force | Out-Null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\ServerManager' -Name 'DoNotPopWACConsoleAtSMLaunch' -Value 1 -Type DWord

# Create key and set DoNotOpenAtLogon
New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager' -Force | Out-Null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager' -Name 'DoNotOpenAtLogon' -Value 1 -Type DWord
