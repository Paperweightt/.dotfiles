function neo
{
    & "$HOME\.dotfiles\neo\neo.ps1"
}

function admin
{
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Start-Process -FilePath "pwsh" -ArgumentList "-NoExit" `
            -Verb RunAs
        exit
    }
}

function killnvim
{
    Stop-Process -Name nvim -Force
}

oh-my-posh init pwsh --config "C:\Users\henry\.dotfiles\powershell\oh-my-posh.omp.json"| Invoke-Expression
