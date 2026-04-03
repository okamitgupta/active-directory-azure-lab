# PowerShell Script to Apply Password Policy
# This script applies a comprehensive password policy to the amit.com domain

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Password Policy Configuration Script" -ForegroundColor Cyan
Write-Host "Domain: amit.com" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Import the Active Directory module
try {
    Import-Module ActiveDirectory
    Write-Host "Active Directory module loaded successfully." -ForegroundColor Green
} catch {
    Write-Host "Error: Could not import Active Directory module. Please ensure you are on a Domain Controller." -ForegroundColor Red
    exit
}

# Define password policy parameters
Write-Host "`nApplying password policy to amit.com domain..." -ForegroundColor Yellow

try {
    # Set the default domain password policy
    Set-ADDefaultDomainPasswordPolicy -Identity 'amit.com' `
        -MaxPasswordAge (New-TimeSpan -Days 90) `
        -MinPasswordLength 12 `
        -PasswordHistoryCount 5 `
        -ComplexityEnabled $true `
        -ReversibleEncryptionEnabled $false `
        -LockoutDuration (New-TimeSpan -Minutes 30) `
        -LockoutObservationWindow (New-TimeSpan -Minutes 30) `
        -LockoutThreshold 5
    
    Write-Host "✓ Password policy successfully applied!" -ForegroundColor Green
} catch {
    Write-Host "Error applying password policy: $_" -ForegroundColor Red
    exit
}

# Display the applied policy
Write-Host "`nApplied Password Policy Details:" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

$policy = Get-ADDefaultDomainPasswordPolicy -Identity 'amit.com'

Write-Host "Minimum Password Length: $($policy.MinPasswordLength) characters" -ForegroundColor White
Write-Host "Password History Count: $($policy.PasswordHistoryCount) passwords" -ForegroundColor White
Write-Host "Maximum Password Age: $($policy.MaxPasswordAge.Days) days" -ForegroundColor White
Write-Host "Minimum Password Age: $($policy.MinPasswordAge.Days) days" -ForegroundColor White
Write-Host "Password Complexity Required: $($policy.ComplexityEnabled)" -ForegroundColor White
Write-Host "Reversible Encryption: $($policy.ReversibleEncryptionEnabled)" -ForegroundColor White
Write-Host "Account Lockout Threshold: $($policy.LockoutThreshold) failed attempts" -ForegroundColor White
Write-Host "Account Lockout Duration: $($policy.LockoutDuration.Minutes) minutes" -ForegroundColor White
Write-Host "Account Lockout Observation Window: $($policy.LockoutObservationWindow.Minutes) minutes" -ForegroundColor White

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Password policy configuration complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green