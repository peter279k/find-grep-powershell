param(
    [Parameter(Mandatory=$true)]
    [string]$SearchDir,      # 對應原本 cd 的路徑

    [Parameter(Mandatory=$true)]
    [string]$ReqNumFile      # 對應原本 Get-Content 的檔案路徑
)

Set-Location $SearchDir

foreach ($ReqNum in Get-Content $ReqNumFile) {
    $count = (Get-ChildItem -Recurse -File 2>$null |
              Select-String -Pattern $ReqNum 2>$null).Count
    "{0}: {1}" -f $ReqNum, $count
}
