# Очистка экрана
# Удаление переменных
cls
Remove-Variable -Name * -Force -ErrorAction SilentlyContinue



## # Функции сеанса

# Переход в каталог проектов
function cd_catalog() {
cd $path_to_project
}



## Приветствие





''
'      Hello World!'
' ______________________'
''
' Это скрипт для создания нового Web ПРОЕКТА (локального сайта, хоста) на локальном сервере XAMPP.'
' В скрипте используется новый шаблон структуры проекта (сайта, 2018):'
''
'    Ваш-Проект-v2018.loc'
'        ../_PROJECT_'             
'          /logs'
'          /www'
'              /.gitignore'
'              /.htaccess'
'              /index.html'
'              /index.php'
'              /README.md'
'          /ThisProject.todo'
''
' Последовательно выполняя указанные инструкции, вы установите и правильно настроите свой проект (локальной сайт).'
''
Write-Host ' Если что-то пошло не так ' -ForegroundColor Yellow -NoNewLine
' - просто закройте это окно и снова запустите этот скрипт.'
''

Pause

Clear-Host

## Ввести путь к каталогу, в котором будет создан проект (сайт)
''
'         ЭТАП 1'
' ______________________'
''
' На этом этапе ваш ПРОЕКТ (сайт) будет установлен в выбранный вами КАТАЛОГ.'
' Для этого ведите правильный путь от корня диска до КАТАЛОГА вашего ПРОЕКТА (без закрывающего слеша)' 
' и нажмите Enter'
''
' Например:'
''
'      e:\www\1111\ '
''
' Если каталог уже существует, ничего не произойдет - можно дальше продолжать установку вашего проекта.'
''
Write-Host ' Введите путь к КАТАЛОГУ, в котором будет размещен ваш ПРОЕКТ (сайт):' -ForegroundColor Yellow
''

<#
    Путь к каталогу проекта
    $path_to_project
#>

$path_to_project = Read-Host " Введите путь к каталогу проекта ..."

''
'________________________________________________'
''
Write-Host ' Проект будет создан в каталоге ' -ForegroundColor White -NoNewline 
Write-Host $path_to_project -ForegroundColor Green
''
Write-Host '     Это верно?' -ForegroundColor Yellow -NoNewline
Write-Host '  Y/n:  ' -NoNewline
$yes_not = Read-Host
''
'_______________________________________________'


''

## Ветвление Yes|NO

if ($yes_not -Match "y|Y|д|Д")
{
    cd_catalog($path_to_project)
    # Создать каталог и перейти в него
    # Создать файл в этом новом каталоге

    $project_name = Read-Host ' Введите имя директории  проекта (название проекта)'
    New-Item . -Name $project_name -ItemType Directory
    cd ./$project_name

    New-Item . -Name _PROJECT_ -ItemType Directory
    New-Item . -Name logs -ItemType Directory
    New-Item . -Name ThisProject.todo -ItemType File


    New-Item . -Name www -ItemType Directory
    cd ./www
    New-Item . -Name .gitignore -ItemType File
    New-Item . -Name .htaccess -ItemType File
    New-Item . -Name README.md -ItemType File

    # Создание файла index.html
    # Код, который записывается в index.html файл:
    $index_html_code = 
"<!DOCTYPE html>
<html lang=`"en`">

<head>
    <meta charset=`"UTF-8`">
    <title>Проект $project_name</title>
</head>

<body>

    <h1>Hello World!</h1>
    <div style=`"color: green`">Ваш новый локальный хост (сайт) готов!</div>
    <div><a href=`"http://$project_name`">http://$project_name</a></div>

</body>
</html>"
    New-Item . -Name index.html -ItemType File -Value $index_html_code
    
    # Создание файла index.php
    # Код, который записывается в index.php файл:
    $index_php_code = 
"
<?php
/**
 * PHP Version 7
 * Начальный index-файл (заглушка)
 * @author   AZWebDDS <AZWebDDS@gmail.com>
 * @link     http://$project_name
 */
 
echo '<h1>Hello World!</h1>';
echo '<div style=`"color: green`">Ваш новый локальный хост (сайт) готов!</div>';
echo '<div><a href=`"http://$project_name`">http://$project_name</a></div>';

phpinfo();
"
    New-Item . -Name index.php -ItemType File -Value $index_php_code

    
    # Проверка директории сайта
    dir

    ## Создание записи в vhost файле XAMPPa
    $record_to_vhosts_file = 
    "
    # Вирт. хост http://$project_name
    <VirtualHost *:80>
        ServerAdmin webmaster@$project_name
        DocumentRoot `"$path_to_project\$project_name\www`"
        ServerName $project_name
        ErrorLog `"$path_to_project\$project_name\logs\error.log`"
        CustomLog `"$path_to_project\$project_name\logs\access.log`" common
    </VirtualHost>
    <Directory `"$path_to_project\$project_name\www`">
        AllowOverride All
        Require all granted
    </Directory>"
    $record_to_vhosts_file | Out-File -FilePath f:\2018\DevProg\WebDev\XAMPP-722-0-VC15\apache\conf\extra\httpd-vhosts.conf -Append -Encoding utf8
    

    ## Создание записи в файле hosts

    ## Автоматическое создание записи в файле hosts временно отключено 
    ## и осуществялется вручную после установки проекта.

    <#
    $end_to_hosts_file = Write-Host '127.0.0.1' $($project_name)
    Start-Process powershell "-NoExit -Command `"Add-Content -Path 'c:\Windows\System32\drivers\etc\hosts' -Value `"$end_to_hosts_file`"`"" -Verb RunAs
    #>



    ## Окончание работы скрипта

    ''
    Write-Host 'Ожидайте окончания работы скрипта (ок. 5 сек.)' -ForegroundColor Cyan
    Start-Sleep -Seconds 5

    ''
    'Все хорошо. Скрипт закончил работу.'
    ''
    'До свидания.'
    Start-Sleep -Seconds 3

    # Pause

}
else
{
    'ни то ни се'
}

''
# Pause