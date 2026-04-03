# PowerShell Script to Create Domain and Join Client Machine
# This script sets up the AD domain 'amit.com' and configures client1 machine

# =====================================================
# Part 1: Create the Domain (Run on Domain Controller)
# =====================================================

# Install Active Directory Domain Services
Write-Host "Installing Active Directory Domain Services..." -ForegroundColor Green
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Import the ADDSDeployment module
Import-Module ADDSDeployment

# Create the forest and domain
$SafeModeAdminPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force

Write-Host "Creating forest and domain 'amit.com'..." -ForegroundColor Green
Install-ADDSForest `
    -DomainName "amit.com" `
    -DomainNetbiosName "AMIT" `
    -ForestMode "WinThreshold" `
    -DomainMode "WinThreshold" `
    -SafeModeAdministratorPassword $SafeModeAdminPassword `
    -InstallDns `
    -Force `
    -NoRebootOnCompletion

Write-Host "Domain 'amit.com' has been created successfully." -ForegroundColor Green

# ===================================================
# Part 2: Join Client Machine (Run on client1)
# ===================================================

# After domain creation and DC restart, run this section on the client machine 'client1'

Write-Host "`n=== Client Machine Configuration ===" -ForegroundColor Cyan

# Set the DNS server to point to the domain controller
Write-Host "Configuring DNS settings..." -ForegroundColor Green
$NetworkAdapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1
$DomainControllerIP = "192.168.1.10"  # Replace with your DC IP

if ($NetworkAdapter) {
    Set-DnsClientServerAddress -InterfaceIndex $NetworkAdapter.IfIndex -ServerAddresses $DomainControllerIP
    Write-Host "DNS configured to use DC IP: $DomainControllerIP" -ForegroundColor Green
}

# Join the computer to the domain
Write-Host "Joining 'client1' to 'amit.com' domain..." -ForegroundColor Green
$DomainCredential = Get-Credential -Message "Enter domain admin credentials"
Add-Computer -DomainName "amit.com" -Credential $DomainCredential -ComputerName "client1" -Restart

Write-Host "Computer 'client1' has been joined to the domain 'amit.com'." -ForegroundColor Green