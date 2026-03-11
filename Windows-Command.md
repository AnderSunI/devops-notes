# Шпаргалка по Windows (для боевых будней)

## 📁 Навигация и работа с файлами (cmd)

Команда | Что делает | Частые аргументы | Пример | Аналог в Linux
---|---|---|---|---
`cd <папка>` | Сменить папку | `cd ..` (на уровень вверх) | `cd C:\Windows` | `cd`
`dir` | Показать содержимое папки | `/a` (включая скрытые), `/s` (с подпапками) | `dir /a` | `ls`
`mkdir <папка>` | Создать папку | | `mkdir C:\script` | `mkdir`
`rmdir /s /q <папка>` | Удалить папку с содержимым | `/s` (с подпапками), `/q` (без спроса) | `rmdir /s /q C:\temp` | `rm -rf`
`copy <файл1> <файл2>` | Скопировать файл | `/y` (без подтверждения) | `copy a.txt b.txt` | `cp`
`move <файл1> <папка/>` | Переместить/переименовать | | `move file.txt C:\new\` | `mv`
`del <файл>` | Удалить файл | `/f` (принудительно), `/s` (рекурсивно) | `del /f /s *.tmp` | `rm`
`type <файл>` | Вывести содержимое файла | | `type C:\log.txt` | `cat`
`notepad <файл>` | Открыть в Блокноте | | `notepad C:\script.ps1` | `nano`

## ⚡️ PowerShell (современный инструмент)

Команда | Что делает | Пример | Аналог в Linux (bash)
---|---|---|---
`Get-ChildItem` (или `dir`, `ls`) | Показать содержимое папки | `Get-ChildItem -Recurse` | `ls -R`
`Set-Location` (или `cd`) | Сменить папку | `Set-Location C:\` | `cd`
`Get-Content <файл>` (или `cat`) | Прочитать файл | `Get-Content log.txt -Tail 50` | `tail -n 50`
`Select-String <паттерн>` | Найти текст в файлах | `Get-ChildItem -Recurse \*.log \| Select-String "ERROR"` | `grep -r "ERROR"`
`Get-Process` | Список процессов | `Get-Process \| Where-Object {$_.CPU -gt 50}` | `ps aux \| awk`
`Stop-Process -Name <имя>` | Остановить процесс | `Stop-Process -Name notepad` | `killall`
`Get-Service` | Список служб | `Get-Service \| Where-Object {$_.Status -eq "Running"}` | `systemctl list-units`
`Restart-Service <имя>` | Перезапустить службу | `Restart-Service Spooler` | `systemctl restart`
`Get-EventLog -LogName System` | Просмотр событий | `Get-EventLog -LogName System -Newest 50` | `journalctl -xe`
`Test-Connection <хост>` | Пинг (аналог ping) | `Test-Connection ya.ru -Count 2` | `ping -c 2`
`Resolve-DnsName <хост>` | NSLookup (аналог nslookup) | `Resolve-DnsName lab.local` | `nslookup` или `dig`
`Get-NetIPAddress` | Показать IP-адреса | `Get-NetIPAddress \| Where-Object {$_.AddressFamily -eq "IPv4"}` | `ip a`
`Get-NetTCPConnection` | Показать открытые порты | `Get-NetTCPConnection -State Listen` | `ss -tulpn` или `netstat`
`Invoke-WebRequest <URL>` | Скачать файл (аналог wget/curl) | `Invoke-WebRequest -Uri example.com/file.zip -OutFile file.zip` | `wget` или `curl`

## 🌐 Сеть и диагностика

Команда | Что делает | Пример | Аналог в Linux
---|---|---|---
`ipconfig` | Показать IP-конфигурацию | `ipconfig /all` (подробно) | `ip a`
`ping <хост>` | Проверить доступность | `ping -t ya.ru` (бесконечно) | `ping`
`tracert <хост>` | Трассировка маршрута | `tracert google.com` | `traceroute`
`nslookup <имя>` | Запрос DNS | `nslookup lab.local` | `nslookup` или `dig`
`netstat -an` | Показать все соединения и порты | `netstat -an \| findstr "LISTENING"` | `ss -an` или `netstat`
`route print` | Показать таблицу маршрутизации | | `route -n`
`arp -a` | Показать ARP-таблицу | | `arp -n`
`Get-NetNeighbor` (PowerShell) | То же, что arp -a | | `ip neigh`

## 👥 Управление Active Directory (PowerShell, модуль AD)

Команда | Что делает | Пример
---|---|---
`Get-ADUser -Filter *` | Получить всех пользователей | `Get-ADUser -Filter * -Properties *`
`New-ADUser` | Создать нового пользователя | `New-ADUser -Name "Иванов Иван" -SamAccountName i.ivanov -UserPrincipalName i.ivanov@lab.local -Enabled $true -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force)`
`Remove-ADUser <логин>` | Удалить пользователя | `Remove-ADUser i.ivanov -Confirm:$false`
`Get-ADGroup -Filter *` | Получить все группы | `Get-ADGroup -Filter "Name -like 'Dept*'"`
`Add-ADGroupMember` | Добавить пользователя в группу | `Add-ADGroupMember -Identity "Dept_IT" -Members i.ivanov`
`Get-ADComputer -Filter *` | Получить все компьютеры в домене | `Get-ADComputer -Filter "Name -like 'PC*'"`
`Get-ADOrganizationalUnit` | Получить список OU | `Get-ADOrganizationalUnit -Filter *`

## 🖥️ Конфигурация системы и реестр

Команда | Что делает | Пример
---|---|---
`regedit` | Открыть редактор реестра | (запуск из командной строки)
`Get-ItemProperty -Path <путь>` | Чтение значения реестра (PS) | `Get-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper`
`Set-ItemProperty -Path <путь>` | Запись значения реестра (PS) | `Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallpaperStyle -Value 2`
`systeminfo` | Информация о системе (версия ОС, патчи) |
`msinfo32` | Графическая утилита информации о системе |
`dxdiag` | Диагностика DirectX |

## 🛠️ Управление дисками и разделами

Команда | Что делает | Пример
---|---|---
`diskmgmt.msc` | Открыть оснастку "Управление дисками" | (запуск из командной строки)
`diskpart` | Утилита командной строки для работы с дисками | `list disk`, `select disk 0`, `clean` (ОЧЕНЬ ОСТОРОЖНО!)
`Get-Disk` (PowerShell) | Просмотр дисков | `Get-Disk \| Where-Object {$_.OperationalStatus -eq "Online"}`
`New-Partition` (PowerShell) | Создать раздел | `New-Partition -DiskNumber 0 -UseMaximumSize -DriveLetter D`
`Format-Volume` (PowerShell) | Форматировать том | `Format-Volume -DriveLetter D -FileSystem NTFS -NewFileSystemLabel "Data"`
`Get-Volume` (PowerShell) | Просмотр томов | `Get-Volume -DriveLetter C`

## 🚀 Групповые политики (GPO)

Команда | Что делает | Пример
---|---|---
`gpmc.msc` | Открыть консоль управления групповыми политиками | (на сервере)
`gpupdate /force` | Принудительно обновить политики на клиенте |
`gpresult /r` | Показать применённые политики (на клиенте) |
`Get-GPO -All` (PowerShell) | Получить список всех GPO в домене | `Get-GPO -All \| Select DisplayName`
`New-GPO -Name <имя>` (PowerShell) | Создать новую GPO | `New-GPO -Name "TestPolicy"`

## 🔧 Полезное (для нашей лабы)

Команда/Действие | Описание | Пример
---|---|---
`Set-ExecutionPolicy RemoteSigned -Scope Process` | Разрешить запуск скриптов для текущей сессии PowerShell | Выполнять перед запуском `.ps1` скриптов.
`Add-WindowsCapability -Name Rsat.ActiveDirectory.DS-LDS.Tools... -Online` | Установка средств удалённого администрирования (RSAT) для AD на сервере |
`ConvertTo-SecureString <строка> -AsPlainText -Force` | Преобразовать пароль в безопасную строку для командлетов AD |
`Out-File -FilePath <путь> -Append` | Добавить строку в конец файла (для логов) | `"Лог: операция выполнена" \| Out-File -FilePath C:\log.txt -Append`
`Start-Transcript -Path <путь>` | Начать запись всего, что выводится в консоль, в лог-файл (полезно для отладки скриптов) |

## 🚫 Решение проблем (наши грабли)

Проблема | Причина | Решение
---|---|---
`Access is denied` при создании пользователя | Скрипт запущен без прав администратора домена | Запустить PowerShell от имени администратора домена (`LAB\Administrator`).
`The password does not meet the requirements` | Пароль не соответствует политике сложности домена | Временно ослабить политику паролей или генерировать более сложный пароль.
Скрипт падает с ошибками про `-GivenName` | Неправильный перенос строк в команде `New-ADUser` | Сделать команду одной длинной строкой или расставить бэктики `` ` `` в конце строк.
Не работают политики для Edge | Нет ADMX-шаблонов Edge на сервере | Скачать и установить административные шаблоны Microsoft Edge.
Политика не применяется на клиенте | Не перелогинился или не та ветка GPO | Проверить `gpresult /r`. Применить политику к правильной OU (пользователи/компьютеры).

## 🔑 Работа с паролями и учётными записями

Действие | Команда (PowerShell)
---|---
Сбросить пароль пользователя | `Set-ADAccountPassword -Identity <логин> -NewPassword (ConvertTo-SecureString "НовыйПароль123" -AsPlainText -Force)`
Включить учётную запись | `Enable-ADAccount -Identity <логин>`
Отключить учётную запись | `Disable-ADAccount -Identity <логин>`
Разблокировать учётную запись | `Unlock-ADAccount -Identity <логин>`
Запретить смену пароля при входе | `Set-ADUser -Identity <логин> -ChangePasswordAtLogon $false`

## 📜 История команд в PowerShell
*   `Get-History` — показать историю команд текущей сессии.
*   `history` — алиас для `Get-History`.
*   Стрелки вверх/вниз — прокрутка ранее введённых команд.
*   `Ctrl+R` — поиск по истории команд (как в Linux).
