# PowerShell Script to Apply Password Policy

# This script applies a password policy to the domain amit.com

# Import the Active Directory module
Import-Module ActiveDirectory

# Set the password policy parameters
define password policy parameters here

# Apply the password policy to the domain
Set-ADDefaultDomainPasswordPolicy -Identity 'amit.com' -MaxPasswordAge (New-TimeSpan -Days 90) -MinPasswordLength 12 -PasswordHistoryCount 5 -ComplexityEnabled $true

Write-Host 'Password policy has been applied to the domain amit.com'