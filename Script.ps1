<# 
    TLDR: This script kills buggy, hidden instances of chrome and chromedriver caused by Selenide/Selenium Automated Functional Tests (AFT's) that are wasting resources on your system. It does not kill any active chrome or chromedriver instances being used by you or an AFT.

    The following is a summary of the terminology and behavior of this script:
    An 'invalid' process is an invisible / hidden instance of chrome or chromedriver that is broken and wasting resources on your system. These invalid instances only seem to get left behind on some machines. It does seem that instances get left behind more frequently when tests fail, a test frequently opens and closes many instances of chrome or chromedriver, or you stop/quit a test in the middle of execution.
    A 'valid' process is any chrome or chromedriver instance that is currently active, such as a currently running AFT test, or a regular chrome instance that was opened by you.

    This script identifies which processes are valid and invalid, and kills ONLY the inactive instances it finds. It also prints relevant information to the console as it runs.
 #>

# Declare lists for storing invalid processes and valid processes
$invalidProcesses = @()
$validProcesses = @()

# Grab all processes with the name "chrome"
$chromeProcesses = Get-Process | Where-Object { $_.Name -eq 'chrome'}

# Grab all processes with the name "chromedriver"
$chromedriverProcesses = Get-Process | Where-Object { $_.Name -match 'chromedriver' }

# Loop over each process in the chrome process list
foreach ($process in $chromeProcesses) {

    # Get the parent process ID (PPID) for the current process object
    $id = $process.Id
    $ppid = (Get-WmiObject -Query "SELECT ParentProcessId FROM Win32_Process WHERE ProcessId = $id").ParentProcessId

    try 
    {
        # Get the parent process object of the current process object using its PPID
        $parentProcess = Get-Process -Id $ppid -ErrorAction Stop

        # If the name of the parent process is "chrome", "explorer", or "chromedriver", it is a valid instance of chrome. Otherwise, it is an invalid instance.
        if ($parentProcess -and ($parentProcess.Name -eq 'chrome' -or $parentProcess.Name -eq 'explorer' -or $parentProcess.Name -eq 'chromedriver')) {
            $validProcesses += $process            
        }
        else {
            $invalidProcesses += $process
        }
    }
    catch {
        # If the current process's parent was not found / does not exist, the process is invalid.
        $invalidProcesses += $process
    }
}

# Threshold of allowable difference in start time between chromedriver and its chrome instances to determine whether the chromedriver instance is valid or not.
$ticksThreshold = 10000000 * 30 # 30 second threshold

# Loop over each process in the chromedriver process list
foreach ($driverProcess in $chromedriverProcesses) {    

    $isInvalid = $true

    # Loop over each process in the valid chrome process list
    # If the absolute difference in start time between the chromedriver instance and any valid chrome process is less than the threshold, the chromedriver instance is valid. Otherwise, it is invalid.
    foreach ($chromeProcess in $validProcesses) { 
        if ([Math]::Abs($chromeProcess.StartTime.Ticks - $driverProcess.StartTime.Ticks) -le $ticksThreshold)
        {
                $validProcesses += $driverProcess
                $isInvalid = $false
                break
        }
    }
    if ($isInvalid -eq $true) {
        $invalidProcesses += $driverProcess
    }
}

# Display valid processes with relevant information in console.
Write-Host "`nValid Instances:"
$validProcesses | Select-Object Id, Name, MainWindowTitle, StartTime | Format-Table -AutoSize

# Display invalid processes with relevant information in console.
Write-Host "`nInvalid Instances:"
$invalidProcesses | Select-Object Id, Name, StartTime | Format-Table -AutoSize

Write-Host "`nKilled The Following Invalid Instances:`n"
# Kill all invalid instances of chrome / chromedriver, and print the name, process ID (PID), and other relevant information to console.
foreach ($process in $invalidProcesses)
{
    try
    {
        $process.kill()
        Write-Host "     - Instance of: '$($process.Name)' with PID: '$($process.Id)'"
    }
    catch
    {
        # Failure to kill the process means that the process exited before the script could kill it. This generally occurs when the script is running while valid instances are in the process of exiting.
        Write-Host "     - Instance of: '$($process.Name)' with PID: '$($process.Id)' already exited"
    }
}


Write-Host "`n`nPress any key to exit ..."

# Uncomment the following line if you want to keep the console open after execution.
#$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
