$BaseKey = 'HKLM:\SOFTWARE\Microsoft\Provisioning\NodeCache\CSP\Device\MS DM Server\Nodes'

$Values = Get-ChildItem -Path $BaseKey | ForEach-Object {
    $SubKeyPath = $_.PsPath
    $Props = Get-ItemProperty -Path $SubKeyPath
	#if ($Props.NodeUri -like "*EnterpriseModernAppManagement*") {continue}
    [PSCustomObject]@{
        #SubKey = $_.PSChildName
        NodeUri = $Props.NodeUri
        ExpectedValue    = $Props.ExpectedValue
    }
}


$Values | ? {$_.NodeUri -notlike "*AppManagement*"}
$Values | ? {$_.NodeUri -like "*DeviceLock*"}