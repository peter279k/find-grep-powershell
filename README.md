# Introduction

- Using the PowerShell script to execute find/grep commands to search specific directories.

# Usage

Using the following command to execute the `run_grep_parallel.ps1`:

```powershell
.\run_grep_parallel.ps1 `
 -SearchDir '{SearchDir1}','{SearchDir2}','{SearchDir3}' `
    -ReqNumFile '{DeepTestFilePath1}','{DeepTestFilePath2}','{DeepTestFilePath3}'
```

Using the following command to execute the `run_find_parallel.ps1`:

```powershell
.\run_find_parallel.ps1 `
 -SearchDir '{SearchDir1}','{SearchDir2}','{SearchDir3}' `
    -ReqNumFile '{DeepTestFilePath1}','{DeepTestFilePath2}','{DeepTestFilePath3}'
```
