# === Параметры ===
$csvPath = "C:\script\users.csv"
$logPath = "C:\script\users_passwords.txt"
$baseFolder = "C:\Shares"
$domain = "lab.local"

function Generate-Password {
    -join ((48..57) + (65..90) + (97..122) + (33, 35, 36, 37, 38) | Get-Random -Count 12 | ForEach-Object { [char]$_ })
}

Write-Host "Импорт пользователей из $csvPath..." -ForegroundColor Yellow
$users = Import-Csv -Path $csvPath -Encoding UTF8

if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Write-Host "Модуль ActiveDirectory не найден. Установите RSAT." -ForegroundColor Red
    exit
}

foreach ($u in $users) {
    $fullName = "$($u.FirstName) $($u.LastName)"
    $sam = $u.SamAccountName
    $dept = $u.Department
    $upn = "$sam@$domain"
    $pass = Generate-Password
    $secPass = ConvertTo-SecureString $pass -AsPlainText -Force

    if (-not (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue)) {
        try {
            New-ADUser -Name $fullName -GivenName $u.FirstName -Surname $u.LastName -SamAccountName $sam -UserPrincipalName $upn -AccountPassword $secPass -Enabled $true -ChangePasswordAtLogon $true -Department $dept

            "$fullName ($sam) : $pass" | Out-File -FilePath $logPath -Append
            Write-Host "✅ Создан: $fullName" -ForegroundColor Green
        } catch {
            Write-Host "❌ Ошибка создания $fullName : $_" -ForegroundColor Red
        }
    } else {
        Write-Host "⏭️ $fullName уже есть" -ForegroundColor Yellow
    }
}
Write-Host "Готово! Пароли в $logPath" -ForegroundColor Cyan
