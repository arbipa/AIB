# Application/Configuration Script for Azure Image builder 
#
# All sorece will be coppied and extrated to c:\temp  as part of the main script from the Azure storage blob
#
# Applications to install:
#
# Coop Fonts
# Microsoft Office 365 2108
# OneDrive  - REMOVED as in Image
# Microsoft Teams - Removed as part of image
# Microsoft VC++ 2013 - DONE
# Thicotic Secret server - DONE
# Citrix Workspace - Done
# Netfx3.5 Enablement - Done 
# Xerox Workspace Cloud Client - DONE
# WEB RTC Redirector - Done
# Adobe Reader DC - DONE


####################################
#                                  #
#  Set up Logging for App Install  #
#                                  #
####################################
#region - 
New-Item c:\Build_Logs -ItemType directory
$logFile = "C:\Build_Logs\" + (get-date -format 'yyyyMMdd') + '_Software_Install.log'

function Write-Log {
    Param($message)
    Write-Output "$(get-date -format 'yyyyMMdd HH:mm:ss') $message" | Out-File -Encoding utf8 $logFile -Append
}
#endregion 



############################################
#                                          #
#  APP Install - Microsoft VC++ 2013 x64   #
#                                          #
############################################
#region 
try {
    Start-Process  'C:\TEMP\Apps\VC++2013\vcredist_x64.exe' -ArgumentList '/quiet' -Wait 
    
    
    if (Test-Path "C:\ProgramData\Package Cache\{929FBD26-9020-399B-9A7A-751D61F0B942}v12.0.21005\packages\vcRuntimeAdditional_amd64\vc_runtimeAdditional_x64.msi") {
        Write-Log "Microsoft VC++2013 x64 has been installed"
    }
    else {
        write-log "Error locating the Microsoft VC++2013 x64 executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Microsoft VC++2013 x64: $ErrorMessage"
}
#endregion 



############################################
#                                          #
#  APP Install - Microsoft VC++ 2013 x86   #
#                                          #
############################################
#region
try {
    Start-Process  "C:\temp\Apps\VC++2013\vcredist_x86.exe" -ArgumentList '/quiet' -Wait 
    
    
    if (Test-Path "C:\ProgramData\Package Cache\{F8CFEB22-A2E7-3971-9EDA-4B11EDEFC185}v12.0.21005\packages\vcRuntimeAdditional_x86\vc_runtimeAdditional_x86.msi") {
        Write-Log "Microsoft VC++2013 x86 has been installed"
    }
    else {
        write-log "Error locating the Microsoft VC++2013 x86 executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Microsoft VC++2013 x86: $ErrorMessage"
} 
#endregion



############################################
#                                          #
#     APP Install - Co-op Fonts 1.2.0      #
#                                          #
############################################
#region 

    Start-Process msiexec.exe -Wait -ArgumentList '/i', 'c:\temp\Apps\Co-op_Fonts_1.2.0\Coop_Fonts_12_EN_001_F.msi /quiet'
    Write-Log "Co-op fonts Installed"

#endregion 




############################################
#                                          #
#   APP Install - Microsoft Office 2108    #
#                                          #
############################################
#region
try {

    Start-Process "C:\TEMP\Apps\Office-2108\setup.exe" -ArgumentList "/configure C:\TEMP\Apps\Office-2108\Configuration1.xml" -wait

  
    if (Test-Path "C:\Program Files (x86)\Microsoft Office\root\Office16\WINWORD") {
        Write-Log "Microsoft Office 365 (2108) has been installed"
    }
    else {
        write-log "Error locating the Microsoft Office 365 (2108) executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Microsoft Office 365 (2108): $ErrorMessage"
}
#endregion





###################################################
#                                                 #
#   APP Install - Microsoft Teams (for Virtual)   #
#                                                 #
###################################################
#region
###################################################
#                                                 #
#      APP Install - Thycotic Secret Server       #
#                                                 #
###################################################
#region
try {
    Start-Process msiexec.exe -Wait -ArgumentList '/i "C:\TEMP\Apps\W10_Thycotic_SSProtocolHandler_6.0.3.7_F_P1\SSProtocolHandler.msi" TRANSFORMS="C:\TEMP\Apps\W10_Thycotic_SSProtocolHandler_6.0.3.7_F_P1\W10_Thycotic_SSProtocolHandler_6.0.3.7_F_P1.Mst"'
    
    if (Test-Path "C:\Program Files\Thycotic Software Ltd\Secret Server Protocol Handler\Thycotic.Logging.dll") {
        Write-Log "Thycotic Secret Server has been installed"
    }
    else {
        write-log "Error locating the Thycotic Secret Server executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Thycotic Secret Server: $ErrorMessage"
}
#endregion


#######################################################
#                                                     #
#    APP Install - Xerox Workplace Cloud Client       #
#                                                     #
#######################################################
#region
try {
    Start-Process msiexec.exe -Wait -ArgumentList '/i "C:\TEMP\Apps\W10_Xerox_WorkplaceCloudClient_5.7.306_F_P1\MSIx64.msi" TRANSFORMS="C:\TEMP\Apps\W10_Xerox_WorkplaceCloudClient_5.7.306_F_P1\W10_Xerox_WorkplaceCloudClient_5.7.306_F_P1.mst" /qn'
    
    if (Test-Path "C:\Program Files\Xerox\Xerox Workplace Cloud Client\JobSubmission\JobSubmission.exe") {
        Write-Log "Xerox Workplace Cloud Client has been installed"
    }
    else {
        write-log "Error locating the Xerox Workplace Cloud Client executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Xerox Workplace Cloud Client: $ErrorMessage"
}
#endregion


##############################################
#                                            #
#       APP Install - Xerox PullPrint        #
#                                            #
##############################################
#region
try {

    Start-Process "C:\TEMP\Apps\W10_Xerox_WorkplaceCloudClient_5.7.306_F_P1\Pullprint_5.860.1.0_PCL6_x64\ntprint.inf_amd64\dpinst64.exe" -ArgumentList "/s" -wait

  
    if (Test-Path "C:\Windows\System32\DriverStore\FileRepository\ntprint.inf_amd64_5e4bd6cd1aa6ba8e\ntprint.inf") {
        Write-Log "Microsoft Xerox PullPrint has been installed"
    }
    else {
        write-log "Error locating the Xerox PullPrint executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Xerox PullPrint: $ErrorMessage"
}
#endregion


##############################################
#                                            #
#       APP Install - WebRTCRedirector       #
#                                            #
##############################################
#region
try {
    Start-Process msiexec.exe -Wait -ArgumentList '/i', 'C:\TEMP\Apps\WebRTCRedirector\MsRdcWebRTCSvc_HostSetup_1.17.2205.23001_x64.msi', '/q'
   
    if (Test-Path "C:\Program Files\Remote Desktop WebRTC Redirector\MsRdcWebRTCSvc.exe") {
        Write-Log "Microsoft Remote Desktop WebRTC Redirector has been installed"
    }
    else {
        write-log "Error locating the Microsoft Remote Desktop WebRTC Redirector executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Microsoft Remote Desktop WebRTC Redirector: $ErrorMessage"
}
#endregion


##############################################
#                                            #
#       APP Install - Adobe Reader DC        #
#                                            #
##############################################
#region
try {
    Start-Process  'C:\TEMP\Apps\Adobe_Acrobat_Reader\setup.exe' -ArgumentList '/quiet' -Wait 
    
    
    if (Test-Path "C:\ProgramData\Package Cache\{929FBD26-9020-399B-9A7A-751D61F0B942}v12.0.21005\packages\vcRuntimeAdditional_amd64\vc_runtimeAdditional_x64.msi") {
        Write-Log "Adobe Reader DC has been installed"
    }
    else {
        write-log "Error locating the Adobe Reader DC executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Adobe Reader DC: $ErrorMessage"
}

#endregion


##############################################
#                                            #
#       Enable - Microsoft .Net FX 3.5       #
#                                            #
##############################################
#region 

############   NEED THE W11 VERSION FROM THE SOURCE DISK ############ 

    dism /online /enable-feature /featurename:NetFX3 /All /Source:C:\TEMP\Apps\W10_Netfx3 /LimitAccess
    write-log "Microsoft .Net fx 3.5 enabled"

#endregion 


###############################################
#                                             #
#   APP Install - OneDrive 22.131.0619.0001   #
#                                             #
###############################################
#region 
try {
    #Start-Process "c:\temp\apps\OneDrive\OneDriveSetup.exe" -ArgumentList "/allusers", "/S" -Wait   
    Start-Process "c:\temp\apps\OneDrive\OneDriveSetup.exe" -ArgumentList "/allusers"  
  
    if (Test-Path "C:\Program Files\Microsoft OneDrive\22.131.0619.0001_2\OneDriveSetup.exe") {
        Write-Log "Microsoft OneDrive has been installed"
    }
    else {
        write-log "Error locating the Microsoft OneDrive executable"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error installing Microsoft OneDrive): $ErrorMessage"
}
#endregion#





####################################################
#     Configuration Items                          #
####################################################   

##########################
#                        #
#     Disable Netbios    #
#                        #
##########################

$regkey = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"
Get-ChildItem $regkey |foreach { Set-ItemProperty -Path "$regkey\$($_.pschildname)" -Name NetbiosOptions -Value 2 -Verbose}



###########################
#                         #
#   Disable Floppy Drive  #
#                         #
###########################

#Get-PnpDevice -Class FloppyDisk | Disable-PnpDevice -Confirm:$false



############################
#                          #
#  Disable Powershell V2   #
#                          #
############################

Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2



############################
#                          #
#      Mask D:\ Drive      #
#                          #
############################

New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer -Name NoDrives -Value '8' -Type Dword



#############################
#                           #
#   Time Zone Redirection   #
#                           #
#############################

$Name = "fEnableTimeZoneRedirection"
$value = "1"

try {
    New-ItemProperty -ErrorAction Stop -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" -Name $name -Value $value -PropertyType DWORD -Force
    if ((Get-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services").PSObject.Properties.Name -contains $name) {
        Write-log "Added time zone redirection registry key"
    }
    else {
        write-log "Error locating the registry key"
    }
}
catch {
    $ErrorMessage = $_.Exception.message
    write-log "Error adding registry KEY: $ErrorMessage"
}



###############################################################
#                                                             #
#           Call MS Supplied Script to apply                  #
# Fix for Microsoft Windows Unquoted Service Path Enumeration #
#                                                             #
###############################################################

$script = $PSScriptRoot+"Scripts\Unquoted_App_Fix\Windows_Path_Enumerate.ps1 -fixuninstall -fixenv"
& $script

###############################################################
#                                                             #
#    Call Windows Virtual Desktop Optimisation Tool (VDOT)    #
#                                                             #
###############################################################

$script = $PSScriptRoot+"Scripts\VDOT\Windows_VDOT.ps1 -Optimizations All -Verbose -AcceptEula"
& $script





#######################################
#                                     #
#       Temp Folder cleaned up        #
#                                     #
#######################################



