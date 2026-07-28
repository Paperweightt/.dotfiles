param(
    [string]$Filter,
    [string]$File
)

$tmp = [IO.Path]::GetTempFileName()

jq $Filter $File | Set-Content $tmp

Move-Item $tmp $File -Force
