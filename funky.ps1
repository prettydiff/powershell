function Get-Funky ([string]$Text, [int]$Iteration) {
    [char[]]$list = $Text.toCharArray()
    [string[]]$color = [string]"Black",[string]"DarkBlue",[string]"DarkGreen",[string]"DarkCyan",[string]"DarkRed",[string]"DarkMagenta",[string]"DarkYellow",[string]"Gray",[string]"DarkGray",[string]"Blue",[string]"Green",[string]"Cyan",[string]"Red",[string]"Magenta",[string]"Yellow",[string]"White"
    [int]$len = $list.length
    [int]$clen = $color.length
    [int]$a = 0
    [int]$b = 0
    [int]$c = Get-Random -Maximum ($clen - 1)
    [int]$iter = If ($Iteration -lt 1) {1} Else {$Iteration}
    if ($len -lt 1) {
        return "The a string value is required for the -Text parameter."
    }
    do {
        $b = 0
        do {
            Write-Host $list[$b] -ForeGroundColor $color[$c] -NoNewLine
            $b = $b + 1
            $c = $c + 1
            if ($c -eq $clen) {
                $c = 0
            }
        } while ($b -lt $len)
        Write-Host "`r`n" -NoNewLine
        $a = $a + 1
    } while ($a -lt $iter)
}