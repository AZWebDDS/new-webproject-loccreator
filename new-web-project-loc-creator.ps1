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
''
'    Ваш-Проект-v2018.loc'
'        ..'
'            _PROJECT_  (для метафайлов IDE, редакторов т.п.)'
'            logs (для логов Apache и т.п.)'
'            htdocs (каталог для размещения самого проекта)'
'                ./app (код ядра вашего приложения, классы)'
'                ./bootstrap (css-фреймворк или автозагрузчик, cashe)'
'                ./config (все конфигурационные файлы)'
'                ./database (миграции и классы для начальных данных или файл SQLite)'
'                ./public (входная точка, содержит index.php и др. ресурсы - img, css, js)'
'                    ././css'
'                        ./././typography.html (файл визуализации шаблонов верстки и типографики)'
'                        ./././header.min.css (минимизированный файл заголовка в css)'
'                        ./././main.min.css (минимизированный файл основной части в css)'
'                        и т.д.'
'                    ././fonts (шрифты)'
'                    ././img (изображения для шаблона)'
'                    ././js'
'                    ././libs (подключаемые библиотеки)'
'                    ././.htaccess'
'                    ././index.html (файл-заглушка)'
'                    ././index.php (файл-заглушка)'
'                    ././README.md (публичное, размещаемое описание проекта)'
'                ./resources (представления, языковые файлы и некомпилированные ресурсы - LESS, SASS, JavaScript)'
'                    ././sass'
'                        ./././vars.sass (файл переменных для SASS)'
'                        ./././header.sass (файл заголовкадля SASS)'
'                        и т.д.'
'                ./routes (маршруты web.php, api.php и console.php)'
'                ./storage (Blade и др. шаблоны разметки, создаваемые сессии, кэши, логи и др., загруженные jpeg, pdf и др.)'
'                ./tests (юнит-тесты)'
'                ./vendor (Composer-зависимости)'
'                ./.gitattributes (файл атрибутов для Git)'
'                ./.gitignore'
'                ./.env (для работы с переменными среды $_ENV)'
'                ./composer.json'
'                ./phpunit.xml (для PHPUnit тестов)'
'            ThisProject.todo (служебное, не размещаемое общее описание проекта и ToDo)'
''
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
    # Создать каталог приложения и перейти в него
    # Создать каталоги и файлы по шаблону

    $project_name = Read-Host ' Введите имя директории  проекта (название проекта)'
    New-Item . -Name $project_name -ItemType Directory
    cd ./$project_name

    New-Item . -Name _PROJECT_ -ItemType Directory
    New-Item . -Name logs -ItemType Directory
    New-Item . -Name htdocs -ItemType Directory
    cd ./htdocs
    New-Item . -Name app -ItemType Directory
    New-Item . -Name bootstrap -ItemType Directory
    New-Item . -Name config -ItemType Directory
    New-Item . -Name database -ItemType Directory
    New-Item . -Name public -ItemType Directory
    cd ././public
    New-Item . -Name css -ItemType Directory
    cd ./././css
    New-Item . -Name typography.html -ItemType File -Value 'Файл визуализации шаблонов верстки и типографики'
    New-Item . -Name header.min.css -ItemType File
    New-Item . -Name main.min.css -ItemType File

    cd $path_to_project/$project_name/htdocs/public
    New-Item . -Name fonts -ItemType Directory
    New-Item . -Name img -ItemType Directory
    New-Item . -Name js -ItemType Directory
    New-Item . -Name libs -ItemType Directory
    New-Item . -Name .htaccess -ItemType File -Value 'AddDefaultCharset UTF-8'
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
    New-Item . -Name README.md -ItemType File -Value 'Публичное, размещаемое описание проекта'

    cd $path_to_project/$project_name/htdocs
    New-Item . -Name resources -ItemType Directory
    cd ././resources
    New-Item . -Name sass -ItemType Directory
    cd ./././sass
    New-Item . -Name vars.sass -ItemType File -Value 'Файл переменных для SASS'
    New-Item . -Name header.sass -ItemType File -Value 'Файл заголовка для SASS' 
    
    cd $path_to_project/$project_name/htdocs                                     
    New-Item . -Name routes -ItemType Directory
    New-Item . -Name storage -ItemType Directory              
    New-Item . -Name tests -ItemType Directory
    New-Item . -Name vendor -ItemType Directory                
    New-Item . -Name .gitattributes -ItemType File 
    New-Item . -Name .gitignore -ItemType File 
    New-Item . -Name .env -ItemType File 
    New-Item . -Name composer.json -ItemType File 
    New-Item . -Name phpunit.xml -ItemType File

    cd $path_to_project/$project_name
    New-Item . -Name ThisProject.todo -ItemType File
    
    # Проверка директории сайта
    dir
    Pause

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
    $record_to_vhosts_file | Out-File -FilePath F:\2018\DevProg\xampp-7240vc15\apache\conf\extra\httpd-vhosts.conf -Append -Encoding utf8
    

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