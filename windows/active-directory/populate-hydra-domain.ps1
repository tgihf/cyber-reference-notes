$Domain = "HYDRA"
$DomainUsername = "$Domain\Administrator"
$LocalUsername = "Administrator"
$Password = ""
$Password = ConvertTo-SecureString -AsPlainText $Password -Force
$DomainCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $DomainUsername, $Password
$LocalCredential = New-Object System.Management.Automation.PSCredential -ArgumentList $LocalUsername, $Password
$Computers = @(
    New-Object PSObject -Property @{
        IPAddress = "10.10.10.20";
        ComputerName = "WS01";
    }
)
foreach ($Computer in $Computers)
{
    Add-Computer -ComputerName $Computer.IPAddress -DomainName $Domain -Credential $DomainCredential -LocalCredential $LocalCredential -Force
    Rename-Computer -ComputerName $Computer.IPAddress -NewName $Computer.ComputerName -DomainCredential $DomainCredential -Restart -Force
}
