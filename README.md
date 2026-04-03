# Azure AD Lab - amit.com Domain

This lab implements a hybrid Active Directory + Azure AD environment with the domain **amit.com**.

## Lab Components

### Infrastructure
- **Domain**: amit.com
- **Domain Controller**: Windows Server 2019/2022
- **Client Machine**: client1
- **Password Policy**: Enforced

### Configuration

#### 1. Domain Setup
- Domain Name: **amit.com**
- Domain NetBIOS Name: **AMIT**
- Forest & Domain Mode: Windows Server 2016 or higher

#### 2. Client Machine
- Computer Name: **client1**
- Status: Joined to amit.com domain

#### 3. Password Policy Applied
- **Minimum Password Length**: 12 characters
- **Password History**: 5 previous passwords
- **Maximum Password Age**: 90 days
- **Password Complexity**: Enabled (requires uppercase, lowercase, numbers, special characters)
- **Account Lockout Threshold**: 5 failed attempts
- **Account Lockout Duration**: 30 minutes

## Scripts

### setup-domain.ps1
Creates the amit.com domain and joins client1 to it.

**Usage (Domain Controller)**:
```powershell
.\scripts\powershell\setup-domain.ps1
```

**Usage (Client Machine)**:
```powershell
# On client1
.\scripts\powershell\setup-domain.ps1
```

### password-policy.ps1
Applies password policy to the domain.

**Usage**:
```powershell
.\scripts\powershell\password-policy.ps1
```

## Prerequisites

- Windows Server 2019 or 2022 for Domain Controller
- Windows 10/11 or Windows Server for client1
- PowerShell 5.0 or higher
- Administrator privileges

## Deployment Steps

1. **On Domain Controller**:
   ```powershell
   .\scripts\powershell\setup-domain.ps1
   ```
   - Installs AD DS
   - Creates amit.com forest and domain
   - Installs DNS

2. **On client1 Machine**:
   - Update DNS to point to DC
   - Run domain join section of setup-domain.ps1
   - Restart the machine

3. **Apply Password Policy**:
   ```powershell
   .\scripts\powershell\password-policy.ps1
   ```
   - Sets password complexity requirements
   - Enforces password length and expiration

## Lab Files Structure

```
okamitgupta/active-directory-azure-lab/
├── scripts/
│   └── powershell/
│       ├── setup-domain.ps1          # Domain and client setup
│       └── password-policy.ps1       # Password policy configuration
├── docs/
│   └── architecture.md               # Lab architecture overview
└── README.md                         # This file
```

## Security Notes

⚠️ **Important**: 
- Change hardcoded passwords in scripts before using in production
- Use secure credential storage (Windows Credential Manager, Azure Key Vault)
- Adjust password policy based on organizational requirements
- Regular backups of Active Directory recommended

## Next Steps

- [ ] Deploy Domain Controller
- [ ] Create client1 VM
- [ ] Run setup-domain.ps1 on DC
- [ ] Join client1 to domain
- [ ] Apply password policy
- [ ] Test domain authentication
- [ ] Set up Group Policies
- [ ] Configure Azure AD Connect for hybrid deployment