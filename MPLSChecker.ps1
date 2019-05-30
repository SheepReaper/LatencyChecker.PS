# Globals
[string]$traceTarget = "www.google.com"
$enableEmailNotification = $true
$consoleWarningThreshold = 500
$consoleCriticalThreshold = 1000
$emailNotificationInterval = 3000
$emailNotificationThreshold = 1000
$smtpServer = "smtp.example.com" # Only support unuthenticated ATM
$emailRecipients = @("someone@example.com")


#$nextResult = Test-NetConnection -ComputerName $traceTarget -TraceRoute
#$option = [System.Management.Automation.Host.ReadKeyOptions]"IncludeKeyDown" #+ [System.Management.Automation.Host.ReadKeyOptions]"NoEcho"
# function ExitKeyPressed {
#     Write-Host($Host.UI.RawUI.KeyAvailable)
#     if ($Host.UI.RawUI.KeyAvailable) {
#         return $Host.UI.RawUI.ReadKey('Noecho,IncludeKeyDown').VirtualKeyCode
#     }
    
#     return $null
# }
function ScanLoop {
    do {
        $result = Test-NetConnection -ComputerName $traceTarget -TraceRoute
        Clear-Host
        $result

        Write-Host "Latency Checker is running, press any key to Pause"
    } until ([Console]::KeyAvailable)
    MainLoop($Host.UI.RawUI.ReadKey().VirtualKeyCode)
}

function MainLoop {
    param(
        $executionpath
    )

    Write-Host "Latency Checker is paused, (Q)uit? Or press Any other key to resume"
    if(!$executionpath){$executionpath = [Console]::ReadKey()}

    switch ($executionPath) {
        81 { break }
        82 { ScanLoop }
        Default { Pause; ScanLoop }
    }
}

ScanLoop
