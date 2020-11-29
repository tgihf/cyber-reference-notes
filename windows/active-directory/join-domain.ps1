$ComputerName = ""
$DomainName = ""
$LocalPassword = ""
$DomainAdminPassword = ""

if ($ComputerName && $DomainName && $LocalPassword && $DomainAdminPassword)
{
    $IsPartOfDomain = (Get-WmiObject -Class Win32_ComputerSystem).PartofDomain
    if ($IsPartOfDomain)
    {
        # Clean up script and batch file
        $BatchPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\join-domain.bat"
        $PSScriptPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\join-domain.ps1"
        Remove-Item -Path $BatchPath -Force
        Remove-Item -Path $PSScriptPath -Force
    }
    else
    {
        # Rename computer
        if ($env:COMPUTERNAME -ne $ComputerName)
        {
            $Username = "Administrator"
            $Password = ConvertTo-SecureString -AsPlainText -Force $LocalPassword
            $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $Password
            Rename-Computer -NewName $ComputerName -LocalCredential $Cred -Force
        }
    
        # Join domain
        $Username = "$Domainname\Administrator"
        $Password = ConvertTo-SecureString -AsPlainText -Force $DomainAdminPassword
        $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, $Password
        Add-Computer -Domainname $DomainName -Credential $Cred -Restart -Force 
    }
}
