# PowerShell-скрипты для автоматизации

- `Create-ADUsers.ps1` — создаёт пользователей в AD из CSV.
- `users.csv` — пример файла с данными для скрипта.

<#
.SYNOPSIS
    Скрипт для массового создания пользователей в Active Directory из CSV-файла.
.DESCRIPTION
    Читает файл users.csv, генерирует пароли, создаёт учётные записи в AD и сохраняет пароли в текстовый файл.
    Требует модуль ActiveDirectory и права администратора домена.
.PARAMETER csvPath
    Путь к CSV-файлу (по умолчанию C:\script\users.csv)
.PARAMETER logPath
    Путь для сохранения паролей (по умолчанию C:\script\users_passwords.txt)
.EXAMPLE
    .\Create-ADUsers.ps1
    Запускает скрипт с параметрами по умолчанию.
#>
