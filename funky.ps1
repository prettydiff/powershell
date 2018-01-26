# Cheney - String coercion and colorful text output
function Get-Funky ([Parameter(Mandatory=$true)][string]$Text,[int]$Iteration,[switch]$Matrix,[switch]$Colorize,[switch]$About) {
    <#
        .DESCRIPTION
        Get funkadelic with this kickass tool!

        .PARAMETER Text
        This mandatory parameter takes either a string or instructions to execute if wrapped in curly braces.

        .PARAMETER Iteration
        Takes an integer to determine how many times to print output to the console. Defaults to 1.

        .PARAMETER Matrix
        Colors the output similar to green console text as seen in the film The Matrix. This parameter takes precidence over Colorize.

        .PARAMETER Colorize
        Rainbow colors upon the output. Parameter Matrix takes precidence over this parameter.

        .PARAMETER About
        Brief information about this module.

        .EXAMPLE
        Get-Funky -Text "hello" -Colorize -Iteration 100
        Get-Funky -Text {ps | ConvertToCSV} -Matrix -About

        .LINK
        https://github.com/prettydiff/powershell

        .NOTES
        https://github.com/prettydiff/powershell
    #>
    [string]$script = $Text -replace "^\{" -replace "\}$"
    [string]$textchars = If ($Text[0] -eq "{" -and $Text[$Text.length - 1] -eq "}") {Invoke-Expression -Command $script} Else {$Text}
    [string[]]$colors = [string]"Black",[string]"DarkBlue",[string]"DarkGreen",[string]"DarkCyan",[string]"DarkRed",[string]"DarkMagenta",[string]"DarkYellow",[string]"Gray",[string]"DarkGray",[string]"Blue",[string]"Green",[string]"Cyan",[string]"Red",[string]"Magenta",[string]"Yellow",[string]"White"
    function colorate {
        [char[]]$list = $textchars.toCharArray()
        [int]$len = $list.length
        [int]$clen = $colors.length
        [int]$a = 0
        [int]$b = 0
        [int]$c = Get-Random -Maximum ($clen - 1)
        [int]$iter = If ($Iteration -lt 1) {1} Else {$Iteration}
        Do {
            $b = 0
            Do {
                If ($b % 24 -eq 0 -and $Matrix -eq $True) {
                    $c = 1
                }
                Write-Host $list[$b] -ForeGroundColor $colors[$c] -NoNewLine
                $b = $b + 1
                If ($Matrix -eq $True) {
                    $c = 0
                } Else {
                    $c = $c + 1
                    If ($c -eq $clen) {
                        $c = 0
                    }
                }
            } While ($b -lt $len)
            Write-Host "`r`n" -NoNewLine
            $a = $a + 1
        } While ($a -lt $iter)
    }
    If ($Matrix -eq $True) {
        $colors = [string]"DarkGreen",[string]"Green"
        $clen = $colors.length
        colorate
    } ElseIf ($Colorize -eq $True) {
        colorate
    } Else {
        Write-Host $textchars
    }
    If ($About -eq $True) {
        Write-Host "`r`n"
        Write-Host "Code written by US Army Signal students"
        Write-Host "Code available at https://github.com/prettydiff/powershell"
        Write-Host "`r`n"
    }
}
New-Alias -Name funkit -Value Get-Funky -Description "Just go funkit" -Force

# Jumper - open cd drive code
function cdopen {
    $Diskmaster = New-Object -ComObject IMAPI2.MsftDiscMaster2
    $DiskRecorder = New-Object -ComObject IMAPI2.MsftDiscRecorder2
    $DiskRecorder.InitializeDiscRecorder($DiskMaster)
    $DiskRecorder.EjectMedia()
}

# Amboy - Application architecture
function Invoke-Matrix {

    # Remove prior written directory, so that there aren't errors later
    $pathy = 'c:\Users\Student\Desktop\Script'
    $pathtest = Test-Path $pathy
    If ($pathtest -eq $True) {
        rm -recurse -force $pathy
    }

    # Amboy - Prompt for user input
    $WhatsYourName = Read-Host -Prompt 'Input your name'
    $NoADC = (Get-NetNeighbor).Count
    $NoADU = $NoADC - (Get-NetNeighbor | ? State -eq Unreachable).Count
    $Today = Get-Date
    Write-Host -ForeGroundColor "Green" "Hello $WhatsYourName as of $Today you have $NoADC neighbors and $NoADU are reachable"
    
    # Oliver - Speech
    Add-Type -AssemblyName System.speech
    $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $speak.speak("Hello $WhatsYourName as of $Today you have $NoADC neighbors and $NoADU are reachable")
    Write-Host "You should have chosen the blue pill..."
    
    # Jumper - Open the CD drive
    Start-Sleep -s 2
    Write-Host "But now Morpheus has haunted your CD drive..."
    cdopen       # function above

    # Oliver - Writing to the file system
    $Output = (Read-Host -Prompt 'Do you want to save IP addresses to a file? Y/N').toLower()
    If ($Output[0] -eq 'y') {
        New-Item -Path $pathy -ItemType dir
	Get-NetNeighbor | Select -Property IPAddress | Out-File 'c:\Users\Student\Desktop\Script\IPAddresses.txt'
    }

    # Cheney - Matrix scrolling
    $x = ps|ConvertTo-HTML;Get-Funky -Text "$x" -Matrix -About -Iteration 1
}