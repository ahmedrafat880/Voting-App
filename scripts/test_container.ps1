$count = 0
do {
    $count++
    Write-Output "[$env:STAGE_NAME] Starting container [Attempt: $count]"
    
    $testStart = Invoke-WebRequest -Uri http://localhost:8000 -UseBasicParsing
    Start-Sleep -s 15
    if ($testStart.statuscode -eq '200') {
        $started = $true
    } else {
        Start-Sleep -Seconds 1
    }
    
} until ($started -or ($count -eq 5))

if (!$started) {
    exit 1
}
