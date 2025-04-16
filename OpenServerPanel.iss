#define AppVersion      "6.2.6"
#define AppVersion_     "6_2_6"
#define AppDomain       "ospanel.io"
#define AppTitle        "Open Server Panel"
#define CurrentYear     GetDateTimeString('yyyy', '', '')

[Setup]

SourceDir               = .
OutputDir               = release
OutputBaseFilename      = open_server_panel_{#AppVersion_}_setup

// Application info

Appid                   = {#AppTitle} {#AppVersion}
AppName                 = {#AppTitle}
AppVersion              = {#AppVersion}
AppVerName              = {#AppTitle} v{#AppVersion}
AppPublisherURL         = https://{#AppDomain}
AppPublisher            = {#AppDomain}
VersionInfoCompany      = {#AppDomain}
VersionInfoVersion      = {#AppVersion}
VersionInfoTextVersion  = {#AppVersion}
VersionInfoDescription  = {#AppTitle}
VersionInfoProductName  = {#AppTitle}
VersionInfoCopyright    = Copyright (c) 2010-{#CurrentYear}, {#AppDomain}

// Compression

Compression          = lzma2/fast
// Compression             = lzma2/ultra64
InternalCompressLevel   = ultra64
LZMAUseSeparateProcess  = yes
SolidCompression        = yes
LZMABlockSize           = 262144
LZMADictionarySize      = 262144
LZMANumBlockThreads     = 4
// LZMANumFastBytes        = 273
LZMANumFastBytes     = 32

// Misc  

AllowNoIcons            = yes
AllowRootDirectory      = yes
AllowUNCPath            = no
AppMutex                = Global\OSPanel
ArchitecturesAllowed    = x64
ArchitecturesInstallIn64BitMode = x64
ChangesEnvironment      = yes
CloseApplications       = no
DefaultDirName          = {sd}\OSPanel
DefaultGroupName        = {#AppTitle}
DisableDirPage          = no
DisableProgramGroupPage = no
DisableReadyPage        = no
DisableStartupPrompt    = yes
DisableWelcomePage      = no
MinVersion              = 6.1sp1
PrivilegesRequired      = lowest 
RestartApplications     = no
SetupMutex              = Global\OSPSetup
ShowLanguageDialog      = auto
Uninstallable           = IsUninstallable
UninstallDisplayName    = {#AppTitle}
UninstallDisplayIcon    = "{app}\bin\ospanel.exe"
UsePreviousAppDir       = no
UsePreviousGroup        = no
UsePreviousLanguage     = no
UsePreviousPrivileges   = no
UsePreviousSetupType    = no
UsePreviousTasks        = no
WizardResizable         = yes

[Languages]

Name: "en";             MessagesFile: "resources\lang\en.isl";    LicenseFile: "LICENSE"; InfoBeforeFile: "resources\lang\en.txt"
Name: "ru";             MessagesFile: "resources\lang\ru.isl";    LicenseFile: "LICENSE"; InfoBeforeFile: "resources\lang\ru.txt"
Name: "ua";             MessagesFile: "resources\lang\ua.isl";    LicenseFile: "LICENSE"; InfoBeforeFile: "resources\lang\ua.txt"
Name: "be";             MessagesFile: "resources\lang\be.isl";    LicenseFile: "LICENSE"; InfoBeforeFile: "resources\lang\be.txt"

[Tasks]

Name: "desktop_icon";   Description:  "{cm:CreateDesktopIcon}";                      Components: core
// Name: "autostarticon";  Description:  "{cm:AutoStartProgram,{#AppTitle}}";        Components: core
Name: "add_to_path";    Description:  "{cm:AddToPath}";                              Components: core
Name: "import_cert";    Description:  "{cm:ImportCert}";                             Components: core

[Icons]

Name: "{group}\{#AppTitle}";              Filename: "{app}\bin\ospanel.exe";        WorkingDir: "{app}";          Components: core;           Flags: createonlyiffileexists
Name: "{group}\System Preparation Tool";  Filename: "{app}\system\bin\syspreptool.exe"; WorkingDir: "{app}";      Components: core;           Flags: createonlyiffileexists
Name: "{group}\{cm:RunManual}";           Filename: "https://github.com/OSPanel/OpenServerPanel/wiki";            Components: core;           Languages: en
Name: "{group}\{cm:RunManual}";           Filename: "https://github.com/OSPanel/OpenServerPanel/wiki/%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F"; Components: core; Languages: ru ua be
Name: "{group}\{cm:RunDonate}";           Filename: "https://ospanel.io/donate/";                                 Components: core
Name: "{group}\{cm:UninstallProgram,{#AppTitle}}"; Filename: "{uninstallexe}";      WorkingDir: "{app}";          Components: core;           Flags: createonlyiffileexists
Name: "{autodesktop}\{#AppTitle}";        Filename: "{app}\bin\ospanel.exe";        WorkingDir: "{app}";          Flags: createonlyiffileexists;    Tasks: desktop_icon
// Name: "{userstartup}\{#AppTitle}";     Filename: "{app}\bin\ospanel.exe";        WorkingDir: "{app}";          Flags: createonlyiffileexists;    Tasks: autostarticon

[Components]

Name: "core";                          Description: "{cm:CoreData}";      Types: full compact;                            Flags: disablenouninstallwarning   
Name: "data";                          Description: "{cm:SubDataPacks}";                                                  Flags: disablenouninstallwarning

Name: "data\browscap";                 Description: "{cm:Browscap}";      Types: full;                                    Flags: disablenouninstallwarning
Name: "data\geobases";                 Description: "{cm:Geobases}";      Types: full compact;                            Flags: disablenouninstallwarning

Name: "addons";                        Description: "{cm:SubAddons}";                                                     Flags: disablenouninstallwarning  

Name: "addons\blackfire";              Description: "Blackfire";          Types: full compact;                            Flags: disablenouninstallwarning
Name: "addons\erlang26";               Description: "Erlang/OTP 26.2";    Types: full;                                    Flags: disablenouninstallwarning 
Name: "addons\ffmpeg71";               Description: "FFMpeg-7.1";         Types: full compact;                            Flags: disablenouninstallwarning
Name: "addons\gs1005";                 Description: "Ghostscript-10.05";  Types: full compact;                            Flags: disablenouninstallwarning
Name: "addons\im71";                   Description: "ImageMagick-7.1";    Types: full compact;                            Flags: disablenouninstallwarning
Name: "addons\nvm";                    Description: "NVM 1.1";            Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer 
Name: "addons\perl532";                Description: "Perl 5.32";          Types: full;                                    Flags: disablenouninstallwarning

Name: "modules";                       Description: "{cm:SubModules}";                                                    Flags: disablenouninstallwarning   

Name: "modules\dns";                   Description: "DNS";                                                                Flags: disablenouninstallwarning
Name: "modules\dns\bind";              Description: "Bind 9.16";          Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer 
Name: "modules\dns\unbound";           Description: "Unbound 1.22";       Types: full;                                    Flags: disablenouninstallwarning

Name: "modules\mail";                  Description: "Mail";                                                               Flags: disablenouninstallwarning
Name: "modules\mail\mailpit";          Description: "Mailpit";            Types: full compact;                            Flags: disablenouninstallwarning
Name: "modules\mail\smtp4dev";         Description: "Smtp4dev";           Types: full compact;                            Flags: disablenouninstallwarning

Name: "modules\mariadb";               Description: "MariaDB";                                                            Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb101";    Description: "MariaDB 10.1";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb102";    Description: "MariaDB 10.2";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb103";    Description: "MariaDB 10.3";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb104";    Description: "MariaDB 10.4";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb105";    Description: "MariaDB 10.5";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb106";    Description: "MariaDB 10.6";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb107";    Description: "MariaDB 10.7";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb108";    Description: "MariaDB 10.8";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb109";    Description: "MariaDB 10.9";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb1010";   Description: "MariaDB 10.10";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb1011";   Description: "MariaDB 10.11";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb110";    Description: "MariaDB 11.0";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb111";    Description: "MariaDB 11.1";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb112";    Description: "MariaDB 11.2";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb114";    Description: "MariaDB 11.4";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mariadb\mariadb117";    Description: "MariaDB 11.7";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "modules\memcached";             Description: "Memcached";                                                          Flags: disablenouninstallwarning
Name: "modules\memcached\memcached14"; Description: "Memcached 1.4";      Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\memcached\memcached16"; Description: "Memcached 1.6";      Types: full;                                    Flags: disablenouninstallwarning

Name: "modules\mongodb";               Description: "MongoDB";                                                            Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb34";     Description: "MongoDB 3.4";        Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb36";     Description: "MongoDB 3.6";        Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb40";     Description: "MongoDB 4.0";        Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb42";     Description: "MongoDB 4.2";        Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb44";     Description: "MongoDB 4.4";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mongodb\mongodb50";     Description: "MongoDB 5.0";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mongodb\mongodb60";     Description: "MongoDB 6.0";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mongodb\mongodb70";     Description: "MongoDB 7.0";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mongodb\mongodb80";     Description: "MongoDB 8.0";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "modules\mysql";                 Description: "MySQL";                                                              Flags: disablenouninstallwarning
Name: "modules\mysql\mysql56";         Description: "MySQL 5.6";          Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\mysql\mysql57";         Description: "MySQL 5.7";          Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mysql\mysql80";         Description: "MySQL 8.0";          Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\mysql\mysql84";         Description: "MySQL 8.4";          Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "modules\nginx";                 Description: "Nginx";                                                              Flags: disablenouninstallwarning
Name: "modules\nginx\nginx122";        Description: "Nginx 1.22";         Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\nginx\nginx127";        Description: "Nginx 1.27";         Types: full compact;                            Flags: disablenouninstallwarning

Name: "modules\php";                   Description: "PHP";                                                                Flags: disablenouninstallwarning
Name: "modules\php\php72";             Description: "PHP 7.2";            Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php72\php72fcgi";   Description: "PHP 7.2 FCGI";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php73";             Description: "PHP 7.3";            Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php73\php73fcgi";   Description: "PHP 7.3 FCGI";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php74";             Description: "PHP 7.4";            Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php74\php74fcgi";   Description: "PHP 7.4 FCGI";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php80";             Description: "PHP 8.0";            Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php80\php80fcgi";   Description: "PHP 8.0 FCGI";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php81";             Description: "PHP 8.1";            Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php81\php81fcgi";   Description: "PHP 8.1 FCGI";       Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\php\php82";             Description: "PHP 8.2";            Types: full compact;                            Flags: disablenouninstallwarning
Name: "modules\php\php82\php82fcgi";   Description: "PHP 8.2 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning
Name: "modules\php\php83";             Description: "PHP 8.3";            Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\php\php83\php83fcgi";   Description: "PHP 8.3 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\php\php84";             Description: "PHP 8.4";            Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\php\php84\php84fcgi";   Description: "PHP 8.4 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "modules\psql";                  Description: "PostgreSQL";                                                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql95";     Description: "PostgreSQL 9.5";     Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\psql\postgresql96";     Description: "PostgreSQL 9.6";     Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\psql\postgresql10";     Description: "PostgreSQL 10";      Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\psql\postgresql11";     Description: "PostgreSQL 11";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\psql\postgresql12";     Description: "PostgreSQL 12";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\psql\postgresql13";     Description: "PostgreSQL 13";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\psql\postgresql14";     Description: "PostgreSQL 14";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\psql\postgresql15";     Description: "PostgreSQL 15";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\psql\postgresql16";     Description: "PostgreSQL 16";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "modules\psql\postgresql17";     Description: "PostgreSQL 17";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "modules\rabbitmq";              Description: "RabbitMQ";                                                           Flags: disablenouninstallwarning
Name: "modules\rabbitmq\rabbitmq313";  Description: "RabbitMQ 3.13";      Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\rabbitmq\rabbitmq40";   Description: "RabbitMQ 4.0";       Types: full;                                    Flags: disablenouninstallwarning

Name: "modules\redis";                 Description: "Redis";                                                              Flags: disablenouninstallwarning
Name: "modules\redis\redis30";         Description: "Redis 3.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\redis\redis32";         Description: "Redis 3.2";          Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\redis\redis40";         Description: "Redis 4.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\redis\redis50";         Description: "Redis 5.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\redis\redis70";         Description: "Redis 7.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\redis\redis72";         Description: "Redis 7.2";          Types: full;                                    Flags: disablenouninstallwarning
Name: "modules\redis\redis74";         Description: "Redis 7.4";          Types: full;                                    Flags: disablenouninstallwarning

[Files]

Source: "system\default\menu.dat";      DestName: "menu.dat";     DestDir: "{app}\system";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                  Components: core;                                    Permissions: users-full
Source: "system\default\program.dat";   DestName: "program.dat";  DestDir: "{app}\system";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                  Components: core;                                    Permissions: users-full
Source: "licenses\licenses\*";                                    DestDir: "{app}\licenses";                      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                                    Permissions: users-full
Source: "bin\*";                                                  DestDir: "{app}\bin";                           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                                    Permissions: users-full
Source: "home\*";                                                 DestDir: "{app}\home";                          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite; Components: core;                 Permissions: users-full
Source: "system\*";                                               DestDir: "{app}\system";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                                    Permissions: users-full
Source: "user\ssl\*";                                             DestDir: "{app}\user\ssl";                      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                                    Permissions: users-full
Source: "addons\Perl-5.32\*";                                     DestDir: "{app}\addons\Perl-5.32";              Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: addons\perl532;               Permissions: users-full
Source: "addons\ErlangOTP-26.2\*";                                DestDir: "{app}\addons\ErlangOTP-26.2";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: addons\erlang26;                         Permissions: users-full
Source: "addons\NVM\*";                                           DestDir: "{app}\addons\NVM";                    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: addons\nvm;                              Permissions: users-full
Source: "addons\ImageMagick-7.1\*";                               DestDir: "{app}\addons\ImageMagick-7.1";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: addons\im71;                             Permissions: users-full
Source: "addons\Ghostscript-10.05\*";                             DestDir: "{app}\addons\Ghostscript-10.05";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: addons\gs1005;                           Permissions: users-full
Source: "addons\FFMpeg-7.1\*";                                    DestDir: "{app}\addons\FFMpeg-7.1";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: addons\ffmpeg71;                         Permissions: users-full
Source: "addons\Blackfire\*";                                     DestDir: "{app}\addons\Blackfire";              Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: addons\blackfire;                        Permissions: users-full

Source: "user\browscap\*"; Excludes: "lite_php_browscap.ini";     DestDir: "{app}\user\browscap";                 Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: data\browscap;                 Permissions: users-full
Source: "user\geo\*";                                             DestDir: "{app}\user\geo";                      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: data\geobases;                           Permissions: users-full

Source: "modules\PHP-7.2\*";                                      DestDir: "{app}\modules\PHP-7.2";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: modules\php\php72;            Permissions: users-full
Source: "modules\PHP-7.3\*";                                      DestDir: "{app}\modules\PHP-7.3";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php73;                       Permissions: users-full
Source: "modules\PHP-7.4\*";                                      DestDir: "{app}\modules\PHP-7.4";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php74;                       Permissions: users-full
Source: "modules\PHP-8.0\*";                                      DestDir: "{app}\modules\PHP-8.0";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php80;                       Permissions: users-full
Source: "modules\PHP-8.1\*";                                      DestDir: "{app}\modules\PHP-8.1";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php81;                       Permissions: users-full
Source: "modules\PHP-8.2\*";                                      DestDir: "{app}\modules\PHP-8.2";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php82;                       Permissions: users-full
Source: "modules\PHP-8.3\*";                                      DestDir: "{app}\modules\PHP-8.3";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php83;                       Permissions: users-full
Source: "modules\PHP-8.4\*";                                      DestDir: "{app}\modules\PHP-8.4";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php84;                       Permissions: users-full
Source: "modules\PHP-7.2-FCGI\*";                                 DestDir: "{app}\modules\PHP-7.2-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php72\php72fcgi;             Permissions: users-full
Source: "modules\PHP-7.3-FCGI\*";                                 DestDir: "{app}\modules\PHP-7.3-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php73\php73fcgi;             Permissions: users-full
Source: "modules\PHP-7.4-FCGI\*";                                 DestDir: "{app}\modules\PHP-7.4-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php74\php74fcgi;             Permissions: users-full
Source: "modules\PHP-8.0-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.0-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php80\php80fcgi;             Permissions: users-full
Source: "modules\PHP-8.1-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.1-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php81\php81fcgi;             Permissions: users-full
Source: "modules\PHP-8.2-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.2-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php82\php82fcgi;             Permissions: users-full
Source: "modules\PHP-8.3-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.3-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php83\php83fcgi;             Permissions: users-full
Source: "modules\PHP-8.4-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.4-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php84\php84fcgi;             Permissions: users-full

Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.2\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php72;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.3\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php73;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.4\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php74;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.0\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php80;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.1\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php81;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.2\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php82;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.3\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php83;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.4\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php84;                       Permissions: users-full

Source: "user\browscap\lite_php_browscap.ini";                    DestDir: "{app}\user\browscap";                 Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php72 modules\php\php73 modules\php\php74 modules\php\php80 modules\php\php81 modules\php\php82 modules\php\php83 modules\php\php84 modules\php\php72\php72fcgi modules\php\php73\php73fcgi modules\php\php74\php74fcgi modules\php\php80\php80fcgi modules\php\php81\php81fcgi modules\php\php82\php82fcgi modules\php\php83\php83fcgi modules\php\php84\php84fcgi; Permissions: users-full

Source: "modules\MySQL-5.6\*";                                    DestDir: "{app}\modules\MySQL-5.6";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: modules\mysql\mysql56;        Permissions: users-full
Source: "modules\MySQL-5.7\*";                                    DestDir: "{app}\modules\MySQL-5.7";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mysql\mysql57;                   Permissions: users-full
Source: "modules\MySQL-8.0\*";                                    DestDir: "{app}\modules\MySQL-8.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mysql\mysql80;                   Permissions: users-full
Source: "modules\MySQL-8.4\*";                                    DestDir: "{app}\modules\MySQL-8.4";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mysql\mysql84;                   Permissions: users-full

Source: "modules\MariaDB-10.1\*";                                 DestDir: "{app}\modules\MariaDB-10.1";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb101;              Permissions: users-full
Source: "modules\MariaDB-10.2\*";                                 DestDir: "{app}\modules\MariaDB-10.2";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb102;              Permissions: users-full
Source: "modules\MariaDB-10.3\*";                                 DestDir: "{app}\modules\MariaDB-10.3";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb103;              Permissions: users-full
Source: "modules\MariaDB-10.4\*";                                 DestDir: "{app}\modules\MariaDB-10.4";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb104;              Permissions: users-full
Source: "modules\MariaDB-10.5\*";                                 DestDir: "{app}\modules\MariaDB-10.5";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb105;              Permissions: users-full
Source: "modules\MariaDB-10.6\*";                                 DestDir: "{app}\modules\MariaDB-10.6";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb106;              Permissions: users-full
Source: "modules\MariaDB-10.7\*";                                 DestDir: "{app}\modules\MariaDB-10.7";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb107;              Permissions: users-full
Source: "modules\MariaDB-10.8\*";                                 DestDir: "{app}\modules\MariaDB-10.8";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb108;              Permissions: users-full
Source: "modules\MariaDB-10.9\*";                                 DestDir: "{app}\modules\MariaDB-10.9";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb109;              Permissions: users-full
Source: "modules\MariaDB-10.10\*";                                DestDir: "{app}\modules\MariaDB-10.10";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb1010;             Permissions: users-full
Source: "modules\MariaDB-10.11\*";                                DestDir: "{app}\modules\MariaDB-10.11";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb1011;             Permissions: users-full
Source: "modules\MariaDB-11.0\*";                                 DestDir: "{app}\modules\MariaDB-11.0";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb110;              Permissions: users-full
Source: "modules\MariaDB-11.1\*";                                 DestDir: "{app}\modules\MariaDB-11.1";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb111;              Permissions: users-full
Source: "modules\MariaDB-11.2\*";                                 DestDir: "{app}\modules\MariaDB-11.2";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb112;              Permissions: users-full
Source: "modules\MariaDB-11.4\*";                                 DestDir: "{app}\modules\MariaDB-11.4";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb114;              Permissions: users-full
Source: "modules\MariaDB-11.7\*";                                 DestDir: "{app}\modules\MariaDB-11.7";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb117;              Permissions: users-full

Source: "modules\PostgreSQL-9.5\*";                               DestDir: "{app}\modules\PostgreSQL-9.5";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: modules\psql\postgresql95;     Permissions: users-full
Source: "modules\PostgreSQL-9.6\*";                               DestDir: "{app}\modules\PostgreSQL-9.6";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql96;               Permissions: users-full
Source: "modules\PostgreSQL-10\*";                                DestDir: "{app}\modules\PostgreSQL-10";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql10;               Permissions: users-full
Source: "modules\PostgreSQL-11\*";                                DestDir: "{app}\modules\PostgreSQL-11";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql11;               Permissions: users-full
Source: "modules\PostgreSQL-12\*";                                DestDir: "{app}\modules\PostgreSQL-12";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql12;               Permissions: users-full
Source: "modules\PostgreSQL-13\*";                                DestDir: "{app}\modules\PostgreSQL-13";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql13;               Permissions: users-full
Source: "modules\PostgreSQL-14\*";                                DestDir: "{app}\modules\PostgreSQL-14";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql14;               Permissions: users-full
Source: "modules\PostgreSQL-15\*";                                DestDir: "{app}\modules\PostgreSQL-15";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql15;               Permissions: users-full
Source: "modules\PostgreSQL-16\*";                                DestDir: "{app}\modules\PostgreSQL-16";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql16;               Permissions: users-full
Source: "modules\PostgreSQL-17\*";                                DestDir: "{app}\modules\PostgreSQL-17";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql17;               Permissions: users-full

Source: "modules\MongoDB-3.4\*";                                  DestDir: "{app}\modules\MongoDB-3.4";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: modules\mongodb\mongodb34;    Permissions: users-full
Source: "modules\MongoDB-3.6\*";                                  DestDir: "{app}\modules\MongoDB-3.6";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb36;               Permissions: users-full
Source: "modules\MongoDB-4.0\*";                                  DestDir: "{app}\modules\MongoDB-4.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb40;               Permissions: users-full
Source: "modules\MongoDB-4.2\*";                                  DestDir: "{app}\modules\MongoDB-4.2";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb42;               Permissions: users-full
Source: "modules\MongoDB-4.4\*";                                  DestDir: "{app}\modules\MongoDB-4.4";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb44;               Permissions: users-full
Source: "modules\MongoDB-5.0\*";                                  DestDir: "{app}\modules\MongoDB-5.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb50;               Permissions: users-full
Source: "modules\MongoDB-6.0\*";                                  DestDir: "{app}\modules\MongoDB-6.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb60;               Permissions: users-full
Source: "modules\MongoDB-7.0\*";                                  DestDir: "{app}\modules\MongoDB-7.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb70;               Permissions: users-full
Source: "modules\MongoDB-8.0\*";                                  DestDir: "{app}\modules\MongoDB-8.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb80;               Permissions: users-full

Source: "modules\Memcached-1.4\*";                                DestDir: "{app}\modules\Memcached-1.4";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: modules\memcached\memcached14; Permissions: users-full
Source: "modules\Memcached-1.6\*";                                DestDir: "{app}\modules\Memcached-1.6";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\memcached\memcached16;           Permissions: users-full

Source: "modules\Redis-3.0\*";                                    DestDir: "{app}\modules\Redis-3.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis30;                   Permissions: users-full
Source: "modules\Redis-3.2\*";                                    DestDir: "{app}\modules\Redis-3.2";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis32;                   Permissions: users-full
Source: "modules\Redis-4.0\*";                                    DestDir: "{app}\modules\Redis-4.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis40;                   Permissions: users-full
Source: "modules\Redis-5.0\*";                                    DestDir: "{app}\modules\Redis-5.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis50;                   Permissions: users-full
Source: "modules\Redis-7.0\*";                                    DestDir: "{app}\modules\Redis-7.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis70;                   Permissions: users-full
Source: "modules\Redis-7.2\*";                                    DestDir: "{app}\modules\Redis-7.2";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis72;                   Permissions: users-full
Source: "modules\Redis-7.4\*";                                    DestDir: "{app}\modules\Redis-7.4";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis74;                   Permissions: users-full

Source: "modules\Bind\*";                                         DestDir: "{app}\modules\Bind";                  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\dns\bind;                        Permissions: users-full
Source: "modules\Unbound\*";                                      DestDir: "{app}\modules\Unbound";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\dns\unbound;                     Permissions: users-full
Source: "modules\Nginx-1.22\*";                                   DestDir: "{app}\modules\Nginx-1.22";            Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\nginx\nginx122;                  Permissions: users-full
Source: "modules\Nginx-1.27\*";                                   DestDir: "{app}\modules\Nginx-1.27";            Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\nginx\nginx127;                  Permissions: users-full
Source: "modules\RabbitMQ-3.13\*";                                DestDir: "{app}\modules\RabbitMQ-3.13";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\rabbitmq\rabbitmq313;            Permissions: users-full
Source: "modules\RabbitMQ-4.0\*";                                 DestDir: "{app}\modules\RabbitMQ-4.0";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\rabbitmq\rabbitmq40;             Permissions: users-full
Source: "modules\Mailpit\*";                                      DestDir: "{app}\modules\Mailpit";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mail\mailpit;                    Permissions: users-full
Source: "modules\Smtp4dev\*";                                     DestDir: "{app}\modules\Smtp4dev";              Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mail\smtp4dev;                   Permissions: users-full

Source: "modules\PHP-7.2\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.2\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: modules\php\php72;            Permissions: users-full
Source: "modules\PHP-7.3\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.3\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php73;                       Permissions: users-full
Source: "modules\PHP-7.4\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.4\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php74;                       Permissions: users-full
Source: "modules\PHP-8.0\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.0\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php80;                       Permissions: users-full
Source: "modules\PHP-8.1\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.1\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php81;                       Permissions: users-full
Source: "modules\PHP-8.2\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.2\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php82;                       Permissions: users-full
Source: "modules\PHP-8.3\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.3\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php83;                       Permissions: users-full
Source: "modules\PHP-8.4\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.4\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php84;                       Permissions: users-full
Source: "modules\PHP-7.2-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-7.2-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php72\php72fcgi;             Permissions: users-full
Source: "modules\PHP-7.3-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-7.3-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php73\php73fcgi;             Permissions: users-full
Source: "modules\PHP-7.4-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-7.4-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php74\php74fcgi;             Permissions: users-full
Source: "modules\PHP-8.0-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.0-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php80\php80fcgi;             Permissions: users-full
Source: "modules\PHP-8.1-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.1-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php81\php81fcgi;             Permissions: users-full
Source: "modules\PHP-8.2-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.2-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php82\php82fcgi;             Permissions: users-full
Source: "modules\PHP-8.3-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.3-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php83\php83fcgi;             Permissions: users-full
Source: "modules\PHP-8.4-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.4-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\php\php84\php84fcgi;             Permissions: users-full

Source: "modules\MySQL-5.6\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-5.6\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: modules\mysql\mysql56;        Permissions: users-full
Source: "modules\MySQL-5.7\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-5.7\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mysql\mysql57;                   Permissions: users-full
Source: "modules\MySQL-8.0\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-8.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mysql\mysql80;                   Permissions: users-full
Source: "modules\MySQL-8.4\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-8.4\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mysql\mysql84;                   Permissions: users-full

Source: "modules\MariaDB-10.1\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.1\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb101;              Permissions: users-full
Source: "modules\MariaDB-10.2\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.2\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb102;              Permissions: users-full
Source: "modules\MariaDB-10.3\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.3\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb103;              Permissions: users-full
Source: "modules\MariaDB-10.4\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.4\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb104;              Permissions: users-full
Source: "modules\MariaDB-10.5\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.5\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb105;              Permissions: users-full
Source: "modules\MariaDB-10.6\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.6\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb106;              Permissions: users-full
Source: "modules\MariaDB-10.7\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.7\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb107;              Permissions: users-full
Source: "modules\MariaDB-10.8\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.8\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb108;              Permissions: users-full
Source: "modules\MariaDB-10.9\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.9\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb109;              Permissions: users-full
Source: "modules\MariaDB-10.10\ospanel_data\default\*";           DestDir: "{app}\config\MariaDB-10.10\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb1010;             Permissions: users-full
Source: "modules\MariaDB-10.11\ospanel_data\default\*";           DestDir: "{app}\config\MariaDB-10.11\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb1011;             Permissions: users-full
Source: "modules\MariaDB-11.0\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.0\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb110;              Permissions: users-full
Source: "modules\MariaDB-11.1\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.1\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb111;              Permissions: users-full
Source: "modules\MariaDB-11.2\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.2\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb112;              Permissions: users-full
Source: "modules\MariaDB-11.4\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.4\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb114;              Permissions: users-full
Source: "modules\MariaDB-11.7\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.7\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mariadb\mariadb117;              Permissions: users-full

Source: "modules\PostgreSQL-9.5\ospanel_data\default\*";          DestDir: "{app}\config\PostgreSQL-9.5\default"; Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: modules\psql\postgresql95;     Permissions: users-full
Source: "modules\PostgreSQL-9.6\ospanel_data\default\*";          DestDir: "{app}\config\PostgreSQL-9.6\default"; Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql96;               Permissions: users-full
Source: "modules\PostgreSQL-10\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-10\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql10;               Permissions: users-full
Source: "modules\PostgreSQL-11\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-11\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql11;               Permissions: users-full
Source: "modules\PostgreSQL-12\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-12\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql12;               Permissions: users-full
Source: "modules\PostgreSQL-13\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-13\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql13;               Permissions: users-full
Source: "modules\PostgreSQL-14\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-14\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql14;               Permissions: users-full
Source: "modules\PostgreSQL-15\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-15\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql15;               Permissions: users-full
Source: "modules\PostgreSQL-16\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-16\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql16;               Permissions: users-full
Source: "modules\PostgreSQL-17\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-17\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\psql\postgresql17;               Permissions: users-full

Source: "modules\MongoDB-3.4\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-3.4\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: modules\mongodb\mongodb34;    Permissions: users-full
Source: "modules\MongoDB-3.6\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-3.6\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb36;               Permissions: users-full
Source: "modules\MongoDB-4.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb40;               Permissions: users-full
Source: "modules\MongoDB-4.2\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.2\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb42;               Permissions: users-full
Source: "modules\MongoDB-4.4\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.4\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb44;               Permissions: users-full
Source: "modules\MongoDB-5.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-5.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb50;               Permissions: users-full
Source: "modules\MongoDB-6.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-6.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb60;               Permissions: users-full
Source: "modules\MongoDB-7.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-7.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb70;               Permissions: users-full
Source: "modules\MongoDB-8.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-8.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mongodb\mongodb80;               Permissions: users-full

Source: "modules\Memcached-1.4\ospanel_data\default\*";           DestDir: "{app}\config\Memcached-1.4\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: modules\memcached\memcached14; Permissions: users-full
Source: "modules\Memcached-1.6\ospanel_data\default\*";           DestDir: "{app}\config\Memcached-1.6\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\memcached\memcached16;           Permissions: users-full

Source: "modules\Redis-3.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-3.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis30;                   Permissions: users-full
Source: "modules\Redis-3.2\ospanel_data\default\*";               DestDir: "{app}\config\Redis-3.2\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis32;                   Permissions: users-full
Source: "modules\Redis-4.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-4.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis40;                   Permissions: users-full
Source: "modules\Redis-5.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-5.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis50;                   Permissions: users-full
Source: "modules\Redis-7.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-7.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis70;                   Permissions: users-full
Source: "modules\Redis-7.2\ospanel_data\default\*";               DestDir: "{app}\config\Redis-7.2\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis72;                   Permissions: users-full
Source: "modules\Redis-7.4\ospanel_data\default\*";               DestDir: "{app}\config\Redis-7.4\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\redis\redis74;                   Permissions: users-full

Source: "modules\Bind\ospanel_data\default\*";                    DestDir: "{app}\config\Bind\default";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\dns\bind;                        Permissions: users-full
Source: "modules\Unbound\ospanel_data\default\*";                 DestDir: "{app}\config\Unbound\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\dns\unbound;                     Permissions: users-full
Source: "modules\Nginx-1.22\ospanel_data\default\*";              DestDir: "{app}\config\Nginx-1.22\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\nginx\nginx122;                  Permissions: users-full
Source: "modules\Nginx-1.27\ospanel_data\default\*";              DestDir: "{app}\config\Nginx-1.27\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\nginx\nginx127;                  Permissions: users-full
Source: "modules\RabbitMQ-3.13\ospanel_data\default\*";           DestDir: "{app}\config\RabbitMQ-3.13\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\rabbitmq\rabbitmq313;            Permissions: users-full
Source: "modules\RabbitMQ-4.0\ospanel_data\default\*";            DestDir: "{app}\config\RabbitMQ-4.0\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\rabbitmq\rabbitmq40;             Permissions: users-full
Source: "modules\Mailpit\ospanel_data\default\*";                 DestDir: "{app}\config\Mailpit\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mail\mailpit;                    Permissions: users-full
Source: "modules\Smtp4dev\ospanel_data\default\*";                DestDir: "{app}\config\Smtp4dev\default";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: modules\mail\smtp4dev;                   Permissions: users-full

Source: "modules\PHP-7.2\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.2\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite solidbreak;  Components: modules\php\php72;         Permissions: users-full
Source: "modules\PHP-7.3\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.3\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php73;                    Permissions: users-full
Source: "modules\PHP-7.4\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.4\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php74;                    Permissions: users-full
Source: "modules\PHP-8.0\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.0\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php80;                    Permissions: users-full
Source: "modules\PHP-8.1\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.1\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php81;                    Permissions: users-full
Source: "modules\PHP-8.2\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.2\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php82;                    Permissions: users-full
Source: "modules\PHP-8.3\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.3\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php83;                    Permissions: users-full
Source: "modules\PHP-8.4\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.4\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php84;                    Permissions: users-full
Source: "modules\PHP-7.2-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-7.2-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php72\php72fcgi;          Permissions: users-full
Source: "modules\PHP-7.3-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-7.3-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php73\php73fcgi;          Permissions: users-full
Source: "modules\PHP-7.4-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-7.4-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php74\php74fcgi;          Permissions: users-full
Source: "modules\PHP-8.0-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.0-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php80\php80fcgi;          Permissions: users-full
Source: "modules\PHP-8.1-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.1-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php81\php81fcgi;          Permissions: users-full
Source: "modules\PHP-8.2-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.2-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php82\php82fcgi;          Permissions: users-full
Source: "modules\PHP-8.3-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.3-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php83\php83fcgi;          Permissions: users-full
Source: "modules\PHP-8.4-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.4-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\php\php84\php84fcgi;          Permissions: users-full

Source: "modules\Bind\ospanel_data\default_data\*";               DestDir: "{app}\data\Bind\default";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\dns\bind;                     Permissions: users-full
Source: "modules\Unbound\ospanel_data\default_data\*";            DestDir: "{app}\data\Unbound\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\dns\unbound;                  Permissions: users-full

Source: "modules\MySQL-5.6\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-5.6\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite solidbreak;  Components: modules\mysql\mysql56;     Permissions: users-full
Source: "modules\MySQL-5.7\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-5.7\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mysql\mysql57;                Permissions: users-full
Source: "modules\MySQL-8.0\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-8.0\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mysql\mysql80;                Permissions: users-full
Source: "modules\MySQL-8.4\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-8.4\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mysql\mysql84;                Permissions: users-full

Source: "modules\MariaDB-10.1\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.1\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb101;           Permissions: users-full
Source: "modules\MariaDB-10.2\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.2\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb102;           Permissions: users-full
Source: "modules\MariaDB-10.3\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.3\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb103;           Permissions: users-full
Source: "modules\MariaDB-10.4\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.4\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb104;           Permissions: users-full
Source: "modules\MariaDB-10.5\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.5\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb105;           Permissions: users-full
Source: "modules\MariaDB-10.6\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.6\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb106;           Permissions: users-full
Source: "modules\MariaDB-10.7\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.7\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb107;           Permissions: users-full
Source: "modules\MariaDB-10.8\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.8\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb108;           Permissions: users-full
Source: "modules\MariaDB-10.9\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.9\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb109;           Permissions: users-full
Source: "modules\MariaDB-10.10\ospanel_data\default_data\*";      DestDir: "{app}\data\MariaDB-10.10\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb1010;          Permissions: users-full
Source: "modules\MariaDB-10.11\ospanel_data\default_data\*";      DestDir: "{app}\data\MariaDB-10.11\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb1011;          Permissions: users-full
Source: "modules\MariaDB-11.0\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.0\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb110;           Permissions: users-full
Source: "modules\MariaDB-11.1\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.1\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb111;           Permissions: users-full
Source: "modules\MariaDB-11.2\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.2\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb112;           Permissions: users-full
Source: "modules\MariaDB-11.4\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.4\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb114;           Permissions: users-full
Source: "modules\MariaDB-11.7\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.7\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\mariadb\mariadb117;           Permissions: users-full

Source: "modules\PostgreSQL-9.5\ospanel_data\default_data\*";     DestDir: "{app}\data\PostgreSQL-9.5\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite solidbreak; Components: modules\psql\postgresql95;  Permissions: users-full
Source: "modules\PostgreSQL-9.6\ospanel_data\default_data\*";     DestDir: "{app}\data\PostgreSQL-9.6\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql96;            Permissions: users-full
Source: "modules\PostgreSQL-10\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-10\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql10;            Permissions: users-full
Source: "modules\PostgreSQL-11\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-11\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql11;            Permissions: users-full
Source: "modules\PostgreSQL-12\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-12\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql12;            Permissions: users-full
Source: "modules\PostgreSQL-13\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-13\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql13;            Permissions: users-full
Source: "modules\PostgreSQL-14\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-14\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql14;            Permissions: users-full
Source: "modules\PostgreSQL-15\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-15\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql15;            Permissions: users-full
Source: "modules\PostgreSQL-16\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-16\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql16;            Permissions: users-full
Source: "modules\PostgreSQL-17\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-17\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: modules\psql\postgresql17;            Permissions: users-full

[Run]

Filename: "{app}\system\ssl\gen_root_cert.bat"; WorkingDir: "{app}\system\ssl"; StatusMsg: "{cm:GenCerts}";  Flags: runhidden waituntilterminated skipifdoesntexist; Components: core
Filename: "{app}\system\ssl\add_root_to_certstore.bat"; WorkingDir: "{app}\system\ssl"; StatusMsg: "{cm:ImportingCert}"; Flags: runhidden waituntilterminated skipifdoesntexist skipifsilent; Tasks: import_cert
Filename: "{app}\system\bin\syspreptool.exe"; Description: "{cm:RunSysPrep}"; Flags: postinstall nowait skipifdoesntexist skipifsilent; Components: core

[UninstallRun]

Filename: "{app}\system\ssl\del_root_from_certstore.bat"; WorkingDir: "{app}\system\ssl"; Flags: runhidden waituntilterminated skipifdoesntexist

[UninstallDelete]

Type: filesandordirs; Name: "{app}\bin"
Type: filesandordirs; Name: "{app}\config"
Type: filesandordirs; Name: "{app}\licenses"
Type: filesandordirs; Name: "{app}\modules"
Type: filesandordirs; Name: "{app}\logs"
Type: filesandordirs; Name: "{app}\system"
Type: filesandordirs; Name: "{app}\temp"
Type: filesandordirs; Name: "{app}\user"
Type: dirifempty;     Name: "{app}"

[Code]

var
  ModePage: TInputOptionWizardPage;
  APPInstallMode: Boolean;
             
function GetDriveType(lpRootPathName: string): UInt;
  external 'GetDriveTypeW@kernel32.dll stdcall';

function GetVolumeInformation(
  lpRootPathName: string; lpVolumeNameBuffer: string; nVolumeNameSize: DWORD;
  var lpVolumeSerialNumber: DWORD; var lpMaximumComponentLength: DWORD;
  var lpFileSystemFlags: DWORD; lpFileSystemNameBuffer: string;
  nFileSystemNameSize: DWORD): BOOL;
  external 'GetVolumeInformationW@kernel32.dll stdcall';

const
  MAX_LEN = 32;

procedure TypeComboOnChange(Sender: TObject);
var
  i: Integer;
begin
  if WizardForm.TypesCombo.ItemIndex = 2 then
  begin
    for i := 0 to WizardForm.ComponentsList.Items.Count - 1 do
    begin
      WizardForm.ComponentsList.Checked[i] := False;
    end;
  end;
end;

function IsPathValid(Path: string): Boolean;
var
  I: Integer;
begin
  Path := AnsiUppercase(Path);
  Result :=
    (Length(Path) >= 3) and (Length(Path) <= 32) and
    (Path[1] >= 'A') and (Path[1] <= 'Z') and
    (Path[2] = ':') and
    (Path[3] = '\');

  if Result then
  begin
    for I := 3 to Length(Path) do
    begin
      case Path[I] of
        '0'..'9', 'A'..'Z', '\', '.', '-', '_', '+':
          else 
        begin
          Result := False;
          Break;
        end;
      end;
    end;
  end;
end;

procedure AddTo_Path();
var
	i:		       Integer;
	old_path:	   String;
	final_path:  String;
	add_path:	   String;
	reg_root:	   Integer;
	reg_path:	   String;
	path_arr:	   TArrayOfString;
	update_path: Boolean;
begin
	reg_root := HKEY_CURRENT_USER;
	reg_path := 'Environment';
	add_path := ExpandConstant('{app}') + '\bin';
	RegQueryStringValue(reg_root, reg_path, 'Path', old_path);
	old_path := old_path + ';';

	i := 0;
  update_path := true;

	while (Pos(';', old_path) > 0) do begin
		SetArrayLength(path_arr, i+1);
		path_arr[i] := Copy(old_path, 0, Pos(';', old_path)-1);
		old_path := Copy(old_path, Pos(';', old_path)+1, Length(old_path));
		i := i + 1;

		if add_path = path_arr[i-1] then
  		if IsUninstaller() = true then
				continue
  		else
				update_path := false;

    if path_arr[i-1] <> '' then
		  if i = 1 then
			  final_path := path_arr[i-1]
		  else
        if final_path <> '' then
			    final_path := final_path + ';' + path_arr[i-1]
        else
          final_path := path_arr[i-1]; 
	end;

	if (IsUninstaller() = false) and (update_path = true) and (add_path <> '') then
    if final_path <> '' then
		  final_path := add_path + ';' + final_path
    else
      final_path := add_path;

  StringChangeEx(final_path, ';;', ';', True);
	RegWriteStringValue(reg_root, reg_path, 'Path', final_path);
end; 

function IO_GetDiskType( const s : String ) : Cardinal;
begin
  // 0 - DRIVE_UNKNOWN The drive type cannot be determined.
  // 1 - DRIVE_NO_ROOT_DIR The root path is invalid; for example, there is no volume mounted at the specified Path.
  // 2 - DRIVE_REMOVABLE The drive has removable media; for example, a floppy drive, thumb drive, or flash card reader.
  // 3 - DRIVE_FIXED The drive has fixed media; for example, a hard disk drive or flash drive.
  // 4 - DRIVE_REMOTE The drive is a remote (network) drive.
  // 5 - DRIVE_CDROM The drive is a CD-ROM drive.
  // 6 - DRIVE_RAMDISK The drive is a RAM disk.
  Result := GetDriveType( PAnsiChar( String( s )[ 1 ] + ':\' ) );
end;

function IO_GetPartitionType( const s : String ) : string;
// FAT
// NTFS
var
  NotUsed            : DWORD;
  VolumeFlags        : DWORD;
  VolumeSerialNumber : DWORD;
begin
  SetLength(Result, MAX_LEN);
  if GetVolumeInformation( PAnsiChar( String( s )[ 1 ] + ':\' ), '', 0, VolumeSerialNumber, NotUsed, VolumeFlags, Result, Length(Result)) then 
    begin
      SetLength(Result, Pos(#0, Result) - 1);
      Result := trim(AnsiLowerCase( Result ));
    end else
      Result := '';
end; 

procedure InitializeWizard();
begin
// WizardForm.WelcomeLabel1.Font.Style := [];
  ModePage :=
    CreateInputOptionPage(
      wpLicense, ExpandConstant('{cm:InstallationMode}'), ExpandConstant('{cm:InstallationModeDescr}'), ExpandConstant('{cm:NormalInstallationDescr}') + #13#10#13#10 +
    ExpandConstant('{cm:PortableInstallationDescr}'), True, False);
  ModePage.Add(ExpandConstant('{cm:NormalInstallation}'));
  ModePage.Add(ExpandConstant('{cm:PortableInstallation}'));
  ModePage.Values[0] := True;
  WizardForm.TypesCombo.OnClick := @TypeComboOnChange;
end; 

function IsUninstallable: Boolean;
begin
  APPInstallMode := ModePage.Values[0];
  Result := APPInstallMode;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False;

  if PageID = wpSelectProgramGroup then
  begin
    Result := not IsUninstallable;
    if not Result then
    Result := not WizardIsComponentSelected('core');
  end;
end;

procedure CurPageChanged(CurPageID: Integer);
var
strExistingInstallPath: String;
begin
  if CurPageID = wpSelectDir then
  begin
    APPInstallMode := ModePage.Values[0];
    strExistingInstallPath := '';   
    if not APPInstallMode then WizardForm.NoIconsCheck.Checked := true else 
    WizardForm.NoIconsCheck.Checked := false;

    if RegKeyExists(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#AppTitle} {#AppVersion}_is1') then
      if RegValueExists(HKEY_CURRENT_USER, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#AppTitle} {#AppVersion}_is1', 'InstallLocation') then
        if not RegQueryStringValue(HKCU, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#AppTitle} {#AppVersion}_is1','InstallLocation', strExistingInstallPath) then strExistingInstallPath := '';
     
    if APPInstallMode then begin       
      if (strExistingInstallPath <> '') and DirExists(strExistingInstallPath) then begin
        WizardForm.DirEdit.Text := strExistingInstallPath;
        WizardForm.DirEdit.Enabled := False;
        WizardForm.DirBrowseButton.Enabled := False;
      end else begin
        WizardForm.DirEdit.Enabled := true;
        WizardForm.DirBrowseButton.Enabled := true;
      end;
    end 
    else 
    begin 
        WizardForm.DirEdit.Enabled := true;
        WizardForm.DirBrowseButton.Enabled := true;
    end;
  end;

  if CurPageID = wpSelectTasks then
    begin   
        APPInstallMode := ModePage.Values[0];
        if not APPInstallMode then
        begin
            WizardForm.TasksList.Checked[0] := false;  
            WizardForm.TasksList.Checked[1] := false;
            WizardForm.TasksList.ItemEnabled[0] := false;  
            WizardForm.TasksList.ItemEnabled[1] := false;
        end;
  end;

// if CurPageID = wpFinished then begin
// WizardForm.FinishedHeadingLabel.Font.Style := [];
// end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  Dir: string;
  Msg: string;
  dtype: Cardinal;
begin
  Result := True;
  if CurPageID = wpSelectDir then
  begin
    Dir := WizardForm.DirEdit.Text;

    if not IsPathValid(Dir) then
    begin
      Msg := ExpandConstant('{cm:PathCheckError}');
      if WizardSilent then Log(Msg)
        else MsgBox(Msg, mbError, MB_OK);
      Result := False;
    end;
   
    if IO_GetPartitionType(Dir) <> 'ntfs' then
    begin
      Msg := ExpandConstant('{cm:PartitionTypeError}');
      if WizardSilent then Log(Msg)
        else MsgBox(Msg, mbError, MB_OK);
      Result := False;
    end;
   
    dtype := IO_GetDiskType(Dir);
    
    if ( dtype <> 2 ) and ( dtype <> 3 ) and ( dtype <> 6 ) then
    begin
      Msg := ExpandConstant('{cm:DiskTypeError}');
      if WizardSilent then Log(Msg)
        else MsgBox(Msg, mbError, MB_OK);
      Result := False;
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
	if CurStep = ssPostInstall then
		if WizardIsTaskSelected('add_to_path') then
			AddTo_Path();
end;

function InitializeUninstall(): Boolean;
begin
  // Default to OK
  result := true;

  // If it's in silent mode, exit
  if UninstallSilent() then
  begin
    MsgBox('This setup doesn''t support silent uninstallation.', mbInformation, MB_OK);
    result := false;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    if not UninstallSilent then begin
      if DirExists(ExpandConstant('{app}\data')) then 
        if MsgBox(ExpandConstant('{cm:WantToDeleteDataFolder}'), mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDNO then
            DelTree(ExpandConstant('{app}\data'), True, True, True); 

      if DirExists(ExpandConstant('{app}\home')) then 
        if MsgBox(ExpandConstant('{cm:WantToDeleteHomeFolder}'), mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDNO then
          DelTree(ExpandConstant('{app}\home'), True, True, True);
    end;
    AddTo_Path();
  end;
end;

function IsWindowsVersionOrNewer(Major, Minor: Integer): Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  Result :=
    (Version.Major > Major) or
    ((Version.Major = Major) and (Version.Minor >= Minor));
end;

function IsWindows10OrNewer: Boolean;
begin
  Result := IsWindowsVersionOrNewer(10, 0);
end;
