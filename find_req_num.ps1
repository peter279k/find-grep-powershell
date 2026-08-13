param(
    [Parameter(Mandatory=$true)]
    [string]$SearchDir,

    [Parameter(Mandatory=$true)]
    [string]$ReqNumFile
)

if (-not (Test-Path -LiteralPath $SearchDir)) {
    Write-Error "此 job 收到的路徑無法存取：[$SearchDir]"
    return
}

# 相當於 find ./：列出 SearchDir 底下所有項目的完整路徑（含檔案與資料夾）
$allPaths = Get-ChildItem -LiteralPath $SearchDir -Recurse 2>$null |
            Select-Object -ExpandProperty FullName

foreach ($req_num in Get-Content -LiteralPath $ReqNumFile) {
    # 相當於 grep -c -i $req_num：數出路徑字串中（不分大小寫）含有該編號的筆數
    $count = ($allPaths | Select-String -Pattern $req_num -SimpleMatch).Count

    # 相當於 echo "${req_num} ${count}"
    "{0} {1}" -f $req_num, $count
}
