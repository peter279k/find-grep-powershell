param(
    [Parameter(Mandatory=$true)]
    [string[]]$SearchDir,     # 傳入 N 個目錄

    [Parameter(Mandatory=$true)]
    [string[]]$ReqNumFile     # 傳入 N 個清單檔，與 SearchDir 依位置配對
)

if ($SearchDir.Count -ne $ReqNumFile.Count) {
    Write-Error "SearchDir 與 ReqNumFile 的數量必須相同（各 $($SearchDir.Count) vs $($ReqNumFile.Count)）"
    return
}

$scriptPath = Join-Path $PSScriptRoot 'find_req_num.ps1'
$outputDir  = $PSScriptRoot

# 依索引把兩個陣列配成一組組 task
$tasks = for ($i = 0; $i -lt $SearchDir.Count; $i++) {
    @{ SearchDir = $SearchDir[$i]; ReqNumFile = $ReqNumFile[$i] }
}

# 為每組參數啟動一個背景工作，用清單檔名當 Job 名稱
$jobs = foreach ($t in $tasks) {
    $name = [System.IO.Path]::GetFileNameWithoutExtension($t.ReqNumFile)
    Start-Job -Name $name -FilePath $scriptPath -ArgumentList $t.SearchDir, $t.ReqNumFile
}

Write-Host "已啟動 $($jobs.Count) 個工作，等待完成..."
$jobs | Wait-Job | Out-Null

foreach ($job in $jobs) {
    $outFile = Join-Path $outputDir "result_$($job.Name).txt"
    Receive-Job -Job $job | Out-File -FilePath $outFile -Encoding UTF8
    Write-Host "$($job.Name) 結果已存至：$outFile"
}

$jobs | Remove-Job
