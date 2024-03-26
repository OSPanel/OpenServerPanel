#define AppVersion      "6.0.1"
#define AppVersion_     "6_0_1"
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
Name: "autostarticon";  Description:  "{cm:AutoStartProgram,{#AppTitle}}";           Components: core
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
Name: "{userstartup}\{#AppTitle}";        Filename: "{app}\bin\ospanel.exe";        WorkingDir: "{app}";          Flags: createonlyiffileexists;    Tasks: autostarticon

[Components]

Name: "core";                  Description: "{cm:CoreData}";      Types: full compact;                            Flags: disablenouninstallwarning
Name: "browscap";              Description: "{cm:Browscap}";      Types: full;                                    Flags: disablenouninstallwarning
Name: "geobases";              Description: "{cm:Geobases}";      Types: full compact;                            Flags: disablenouninstallwarning
 
Name: "dns";                   Description: "DNS";                                                                Flags: disablenouninstallwarning
Name: "dns\bind";              Description: "Bind";               Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer 
Name: "dns\unbound";           Description: "Unbound";            Types: full;                                    Flags: disablenouninstallwarning

Name: "mariadb";               Description: "MariaDB";                                                            Flags: disablenouninstallwarning
Name: "mariadb\mariadb101";    Description: "MariaDB 10.1";       Types: full;                                    Flags: disablenouninstallwarning
Name: "mariadb\mariadb102";    Description: "MariaDB 10.2";       Types: full;                                    Flags: disablenouninstallwarning
Name: "mariadb\mariadb103";    Description: "MariaDB 10.3";       Types: full;                                    Flags: disablenouninstallwarning
Name: "mariadb\mariadb104";    Description: "MariaDB 10.4";       Types: full;                                    Flags: disablenouninstallwarning
Name: "mariadb\mariadb105";    Description: "MariaDB 10.5";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb106";    Description: "MariaDB 10.6";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb107";    Description: "MariaDB 10.7";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb108";    Description: "MariaDB 10.8";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb109";    Description: "MariaDB 10.9";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb1010";   Description: "MariaDB 10.10";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb1011";   Description: "MariaDB 10.11";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb110";    Description: "MariaDB 11.0";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb111";    Description: "MariaDB 11.1";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mariadb\mariadb112";    Description: "MariaDB 11.2";       Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "memcached";             Description: "Memcached";                                                          Flags: disablenouninstallwarning
Name: "memcached\memcached14"; Description: "Memcached 1.4";      Types: full;                                    Flags: disablenouninstallwarning
Name: "memcached\memcached16"; Description: "Memcached 1.6";      Types: full;                                    Flags: disablenouninstallwarning

Name: "mongodb";               Description: "MongoDB";                                                            Flags: disablenouninstallwarning
Name: "mongodb\mongodb30";     Description: "MongoDB 3.0";        Types: full;                                    Flags: disablenouninstallwarning
Name: "mongodb\mongodb32";     Description: "MongoDB 3.2";        Types: full;                                    Flags: disablenouninstallwarning
Name: "mongodb\mongodb34";     Description: "MongoDB 3.4";        Types: full;                                    Flags: disablenouninstallwarning
Name: "mongodb\mongodb36";     Description: "MongoDB 3.6";        Types: full;                                    Flags: disablenouninstallwarning
Name: "mongodb\mongodb40";     Description: "MongoDB 4.0";        Types: full;                                    Flags: disablenouninstallwarning
Name: "mongodb\mongodb42";     Description: "MongoDB 4.2";        Types: full;                                    Flags: disablenouninstallwarning
Name: "mongodb\mongodb44";     Description: "MongoDB 4.4";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mongodb\mongodb50";     Description: "MongoDB 5.0";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mongodb\mongodb60";     Description: "MongoDB 6.0";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mongodb\mongodb70";     Description: "MongoDB 7.0";        Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "mysql";                 Description: "MySQL";                                                              Flags: disablenouninstallwarning
Name: "mysql\mysql55";         Description: "MySQL 5.5";          Types: full;                                    Flags: disablenouninstallwarning
Name: "mysql\mysql56";         Description: "MySQL 5.6";          Types: full compact;                            Flags: disablenouninstallwarning
Name: "mysql\mysql57";         Description: "MySQL 5.7";          Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mysql\mysql80";         Description: "MySQL 8.0";          Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "mysql\mysql82";         Description: "MySQL 8.2";          Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "nginx";                 Description: "Nginx";                                                              Flags: disablenouninstallwarning
Name: "nginx\nginx122";        Description: "Nginx 1.22";         Types: full;                                    Flags: disablenouninstallwarning
Name: "nginx\nginx125";        Description: "Nginx 1.25";         Types: full compact;                            Flags: disablenouninstallwarning

Name: "perl";                  Description: "Perl";               Types: full;                                    Flags: disablenouninstallwarning

Name: "php";                   Description: "PHP";                                                                Flags: disablenouninstallwarning
Name: "php\php72";             Description: "PHP 7.2";            Types: full;                                    Flags: disablenouninstallwarning
Name: "php\php72fcgi";         Description: "PHP 7.2 FCGI";       Types: full;                                    Flags: disablenouninstallwarning
Name: "php\php73";             Description: "PHP 7.3";            Types: full;                                    Flags: disablenouninstallwarning
Name: "php\php73fcgi";         Description: "PHP 7.3 FCGI";       Types: full;                                    Flags: disablenouninstallwarning
Name: "php\php74";             Description: "PHP 7.4";            Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php74fcgi";         Description: "PHP 7.4 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php80";             Description: "PHP 8.0";            Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php80fcgi";         Description: "PHP 8.0 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php81";             Description: "PHP 8.1";            Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php81fcgi";         Description: "PHP 8.1 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php82";             Description: "PHP 8.2";            Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php82fcgi";         Description: "PHP 8.2 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning
Name: "php\php83";             Description: "PHP 8.3";            Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "php\php83fcgi";         Description: "PHP 8.3 FCGI";       Types: full compact;                            Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "psql";                  Description: "PostgreSQL";                                                         Flags: disablenouninstallwarning
Name: "psql\postgresql95";     Description: "PostgreSQL 9.5";     Types: full;                                    Flags: disablenouninstallwarning
Name: "psql\postgresql96";     Description: "PostgreSQL 9.6";     Types: full;                                    Flags: disablenouninstallwarning
Name: "psql\postgresql10";     Description: "PostgreSQL 10";      Types: full;                                    Flags: disablenouninstallwarning
Name: "psql\postgresql11";     Description: "PostgreSQL 11";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "psql\postgresql12";     Description: "PostgreSQL 12";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "psql\postgresql13";     Description: "PostgreSQL 13";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "psql\postgresql14";     Description: "PostgreSQL 14";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "psql\postgresql15";     Description: "PostgreSQL 15";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer
Name: "psql\postgresql16";     Description: "PostgreSQL 16";      Types: full;                                    Flags: disablenouninstallwarning; check: IsWindows10OrNewer

Name: "redis";                 Description: "Redis";                                                              Flags: disablenouninstallwarning
Name: "redis\redis30";         Description: "Redis 3.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "redis\redis32";         Description: "Redis 3.2";          Types: full;                                    Flags: disablenouninstallwarning
Name: "redis\redis40";         Description: "Redis 4.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "redis\redis50";         Description: "Redis 5.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "redis\redis70";         Description: "Redis 7.0";          Types: full;                                    Flags: disablenouninstallwarning
Name: "redis\redis72";         Description: "Redis 7.2";          Types: full;                                    Flags: disablenouninstallwarning

[Files]

Source: "system\default\domains.dat";   DestName: "domains.ini";  DestDir: "{app}\config";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                  Components: core;                            Permissions: users-full
Source: "system\default\menu.dat";      DestName: "menu.ini";     DestDir: "{app}\config";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                  Components: core;                            Permissions: users-full
Source: "system\default\program.dat";   DestName: "program.ini";  DestDir: "{app}\config";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                  Components: core;                            Permissions: users-full
Source: "system\default\scheduler.dat"; DestName: "scheduler.ini";DestDir: "{app}\config";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                  Components: core;                            Permissions: users-full
Source: "licenses\licenses\*";                                    DestDir: "{app}\licenses";                      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                            Permissions: users-full
Source: "bin\*";                                                  DestDir: "{app}\bin";                           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                            Permissions: users-full
Source: "home\*";                                                 DestDir: "{app}\home";                          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite; Components: core;         Permissions: users-full
Source: "system\*";                                               DestDir: "{app}\system";                        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                            Permissions: users-full
Source: "user\ssl\*";                                             DestDir: "{app}\user\ssl";                      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                            Permissions: users-full
Source: "modules\ControlPanel\*";                                 DestDir: "{app}\modules\ControlPanel";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core;                            Permissions: users-full
Source: "addons\Perl\*";                                          DestDir: "{app}\addons\Perl";                   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: perl;                 Permissions: users-full

Source: "user\browscap\*"; Excludes: "lite_php_browscap.ini";     DestDir: "{app}\user\browscap";                 Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: browscap;              Permissions: users-full
Source: "user\geo\*";                                             DestDir: "{app}\user\geo";                      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: geobases;                        Permissions: users-full

Source: "modules\PHP-7.2\*";                                      DestDir: "{app}\modules\PHP-7.2";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: php\php72;            Permissions: users-full
Source: "modules\PHP-7.3\*";                                      DestDir: "{app}\modules\PHP-7.3";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73;                       Permissions: users-full
Source: "modules\PHP-7.4\*";                                      DestDir: "{app}\modules\PHP-7.4";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74;                       Permissions: users-full
Source: "modules\PHP-8.0\*";                                      DestDir: "{app}\modules\PHP-8.0";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80;                       Permissions: users-full
Source: "modules\PHP-8.1\*";                                      DestDir: "{app}\modules\PHP-8.1";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81;                       Permissions: users-full
Source: "modules\PHP-8.2\*";                                      DestDir: "{app}\modules\PHP-8.2";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82;                       Permissions: users-full
Source: "modules\PHP-8.3\*";                                      DestDir: "{app}\modules\PHP-8.3";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83;                       Permissions: users-full
Source: "modules\PHP-7.2-FCGI\*";                                 DestDir: "{app}\modules\PHP-7.2-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72fcgi;                   Permissions: users-full
Source: "modules\PHP-7.3-FCGI\*";                                 DestDir: "{app}\modules\PHP-7.3-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73fcgi;                   Permissions: users-full
Source: "modules\PHP-7.4-FCGI\*";                                 DestDir: "{app}\modules\PHP-7.4-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74fcgi;                   Permissions: users-full
Source: "modules\PHP-8.0-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.0-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80fcgi;                   Permissions: users-full
Source: "modules\PHP-8.1-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.1-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81fcgi;                   Permissions: users-full
Source: "modules\PHP-8.2-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.2-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82fcgi;                   Permissions: users-full
Source: "modules\PHP-8.3-FCGI\*";                                 DestDir: "{app}\modules\PHP-8.3-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83fcgi;                   Permissions: users-full

Source: "modules\PHP-7.2\PHP";                                    DestDir: "{app}\modules\PHP-7.2-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72fcgi;                   Permissions: users-full
Source: "modules\PHP-7.3\PHP";                                    DestDir: "{app}\modules\PHP-7.3-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73fcgi;                   Permissions: users-full
Source: "modules\PHP-7.4\PHP";                                    DestDir: "{app}\modules\PHP-7.4-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74fcgi;                   Permissions: users-full
Source: "modules\PHP-8.0\PHP";                                    DestDir: "{app}\modules\PHP-8.0-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80fcgi;                   Permissions: users-full
Source: "modules\PHP-8.1\PHP";                                    DestDir: "{app}\modules\PHP-8.1-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81fcgi;                   Permissions: users-full
Source: "modules\PHP-8.2\PHP";                                    DestDir: "{app}\modules\PHP-8.2-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82fcgi;                   Permissions: users-full
Source: "modules\PHP-8.3\PHP";                                    DestDir: "{app}\modules\PHP-8.3-FCGI";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83fcgi;                   Permissions: users-full

Source: "modules\PHP-7.2\Apache\conf\openssl.cnf";                DestDir: "{app}\modules\PHP-7.2-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72fcgi;                   Permissions: users-full
Source: "modules\PHP-7.3\Apache\conf\openssl.cnf";                DestDir: "{app}\modules\PHP-7.3-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73fcgi;                   Permissions: users-full
Source: "modules\PHP-7.4\Apache\conf\openssl.cnf";                DestDir: "{app}\modules\PHP-7.4-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74fcgi;                   Permissions: users-full
Source: "modules\PHP-8.0\Apache\conf\openssl.cnf";                DestDir: "{app}\modules\PHP-8.0-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80fcgi;                   Permissions: users-full
Source: "modules\PHP-8.1\Apache\conf\openssl.cnf";                DestDir: "{app}\modules\PHP-8.1-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81fcgi;                   Permissions: users-full
Source: "modules\PHP-8.2\Apache\conf\openssl.cnf";                DestDir: "{app}\modules\PHP-8.2-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82fcgi;                   Permissions: users-full
Source: "modules\PHP-8.3\Apache\conf\openssl.cnf";                DestDir: "{app}\modules\PHP-8.3-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83fcgi;                   Permissions: users-full

Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.2\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.3\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.4\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.0\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.1\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.2\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.3\PHP";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83;                       Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.2-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72fcgi;                   Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.3-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73fcgi;                   Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-7.4-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74fcgi;                   Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.0-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80fcgi;                   Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.1-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81fcgi;                   Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.2-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82fcgi;                   Permissions: users-full
Source: "resources\php_bundle\*";                                 DestDir: "{app}\modules\PHP-8.3-FCGI\PHP";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83fcgi;                   Permissions: users-full

Source: "user\browscap\lite_php_browscap.ini";                    DestDir: "{app}\user\browscap";                 Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72 php\php73 php\php74 php\php80 php\php81 php\php82 php\php83 php\php72fcgi php\php73fcgi php\php74fcgi php\php80fcgi php\php81fcgi php\php82fcgi php\php83fcgi; Permissions: users-full

Source: "modules\MySQL-5.5\*";                                    DestDir: "{app}\modules\MySQL-5.5";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: mysql\mysql55;         Permissions: users-full
Source: "modules\MySQL-5.6\*";                                    DestDir: "{app}\modules\MySQL-5.6";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql56;                   Permissions: users-full
Source: "modules\MySQL-5.7\*";                                    DestDir: "{app}\modules\MySQL-5.7";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql57;                   Permissions: users-full
Source: "modules\MySQL-8.0\*";                                    DestDir: "{app}\modules\MySQL-8.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql80;                   Permissions: users-full
Source: "modules\MySQL-8.2\*";                                    DestDir: "{app}\modules\MySQL-8.2";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql82;                   Permissions: users-full

Source: "modules\MariaDB-10.1\*";                                 DestDir: "{app}\modules\MariaDB-10.1";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb101;              Permissions: users-full
Source: "modules\MariaDB-10.2\*";                                 DestDir: "{app}\modules\MariaDB-10.2";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb102;              Permissions: users-full
Source: "modules\MariaDB-10.3\*";                                 DestDir: "{app}\modules\MariaDB-10.3";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb103;              Permissions: users-full
Source: "modules\MariaDB-10.4\*";                                 DestDir: "{app}\modules\MariaDB-10.4";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb104;              Permissions: users-full
Source: "modules\MariaDB-10.5\*";                                 DestDir: "{app}\modules\MariaDB-10.5";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb105;              Permissions: users-full
Source: "modules\MariaDB-10.6\*";                                 DestDir: "{app}\modules\MariaDB-10.6";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb106;              Permissions: users-full
Source: "modules\MariaDB-10.7\*";                                 DestDir: "{app}\modules\MariaDB-10.7";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb107;              Permissions: users-full
Source: "modules\MariaDB-10.8\*";                                 DestDir: "{app}\modules\MariaDB-10.8";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb108;              Permissions: users-full
Source: "modules\MariaDB-10.9\*";                                 DestDir: "{app}\modules\MariaDB-10.9";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb109;              Permissions: users-full
Source: "modules\MariaDB-10.10\*";                                DestDir: "{app}\modules\MariaDB-10.10";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb1010;             Permissions: users-full
Source: "modules\MariaDB-10.11\*";                                DestDir: "{app}\modules\MariaDB-10.11";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb1011;             Permissions: users-full
Source: "modules\MariaDB-11.0\*";                                 DestDir: "{app}\modules\MariaDB-11.0";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb110;              Permissions: users-full
Source: "modules\MariaDB-11.1\*";                                 DestDir: "{app}\modules\MariaDB-11.1";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb111;              Permissions: users-full
Source: "modules\MariaDB-11.2\*";                                 DestDir: "{app}\modules\MariaDB-11.2";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb112;              Permissions: users-full

Source: "modules\PostgreSQL-9.5\*";                               DestDir: "{app}\modules\PostgreSQL-9.5";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: psql\postgresql95;     Permissions: users-full
Source: "modules\PostgreSQL-9.6\*";                               DestDir: "{app}\modules\PostgreSQL-9.6";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql96;               Permissions: users-full
Source: "modules\PostgreSQL-10\*";                                DestDir: "{app}\modules\PostgreSQL-10";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql10;               Permissions: users-full
Source: "modules\PostgreSQL-11\*";                                DestDir: "{app}\modules\PostgreSQL-11";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql11;               Permissions: users-full
Source: "modules\PostgreSQL-12\*";                                DestDir: "{app}\modules\PostgreSQL-12";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql12;               Permissions: users-full
Source: "modules\PostgreSQL-13\*";                                DestDir: "{app}\modules\PostgreSQL-13";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql13;               Permissions: users-full
Source: "modules\PostgreSQL-14\*";                                DestDir: "{app}\modules\PostgreSQL-14";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql14;               Permissions: users-full
Source: "modules\PostgreSQL-15\*";                                DestDir: "{app}\modules\PostgreSQL-15";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql15;               Permissions: users-full
Source: "modules\PostgreSQL-16\*";                                DestDir: "{app}\modules\PostgreSQL-16";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql16;               Permissions: users-full

Source: "modules\MongoDB-3.0\*";                                  DestDir: "{app}\modules\MongoDB-3.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: mongodb\mongodb30;     Permissions: users-full
Source: "modules\MongoDB-3.2\*";                                  DestDir: "{app}\modules\MongoDB-3.2";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb32;               Permissions: users-full
Source: "modules\MongoDB-3.4\*";                                  DestDir: "{app}\modules\MongoDB-3.4";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb34;               Permissions: users-full
Source: "modules\MongoDB-3.6\*";                                  DestDir: "{app}\modules\MongoDB-3.6";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb36;               Permissions: users-full
Source: "modules\MongoDB-4.0\*";                                  DestDir: "{app}\modules\MongoDB-4.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb40;               Permissions: users-full
Source: "modules\MongoDB-4.2\*";                                  DestDir: "{app}\modules\MongoDB-4.2";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb42;               Permissions: users-full
Source: "modules\MongoDB-4.4\*";                                  DestDir: "{app}\modules\MongoDB-4.4";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb44;               Permissions: users-full
Source: "modules\MongoDB-5.0\*";                                  DestDir: "{app}\modules\MongoDB-5.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb50;               Permissions: users-full
Source: "modules\MongoDB-6.0\*";                                  DestDir: "{app}\modules\MongoDB-6.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb60;               Permissions: users-full
Source: "modules\MongoDB-7.0\*";                                  DestDir: "{app}\modules\MongoDB-7.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb70;               Permissions: users-full

Source: "modules\Memcached-1.4\*";                                DestDir: "{app}\modules\Memcached-1.4";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: memcached\memcached14; Permissions: users-full
Source: "modules\Memcached-1.6\*";                                DestDir: "{app}\modules\Memcached-1.6";         Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: memcached\memcached16;           Permissions: users-full

Source: "modules\Redis-3.0\*";                                    DestDir: "{app}\modules\Redis-3.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis30;                   Permissions: users-full
Source: "modules\Redis-3.2\*";                                    DestDir: "{app}\modules\Redis-3.2";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis32;                   Permissions: users-full
Source: "modules\Redis-4.0\*";                                    DestDir: "{app}\modules\Redis-4.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis40;                   Permissions: users-full
Source: "modules\Redis-5.0\*";                                    DestDir: "{app}\modules\Redis-5.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis50;                   Permissions: users-full
Source: "modules\Redis-7.0\*";                                    DestDir: "{app}\modules\Redis-7.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis70;                   Permissions: users-full
Source: "modules\Redis-7.2\*";                                    DestDir: "{app}\modules\Redis-7.2";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis72;                   Permissions: users-full

Source: "modules\Bind\*";                                         DestDir: "{app}\modules\Bind";                  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: dns\bind;                        Permissions: users-full
Source: "modules\Unbound\*";                                      DestDir: "{app}\modules\Unbound";               Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: dns\unbound;                     Permissions: users-full

Source: "modules\Nginx-1.22\*";                                   DestDir: "{app}\modules\Nginx-1.22";            Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: nginx\nginx122;                  Permissions: users-full
Source: "modules\Nginx-1.25\*";                                   DestDir: "{app}\modules\Nginx-1.25";            Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: nginx\nginx125;                  Permissions: users-full

Source: "modules\ControlPanel\ospanel_data\default\*";            DestDir: "{app}\config\ControlPanel\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: core;                  Permissions: users-full

Source: "modules\PHP-7.2\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.2\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak;  Components: php\php72;            Permissions: users-full
Source: "modules\PHP-7.3\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.3\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73;                       Permissions: users-full
Source: "modules\PHP-7.4\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.4\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74;                       Permissions: users-full
Source: "modules\PHP-8.0\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.0\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80;                       Permissions: users-full
Source: "modules\PHP-8.1\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.1\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81;                       Permissions: users-full
Source: "modules\PHP-8.2\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.2\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82;                       Permissions: users-full
Source: "modules\PHP-8.3\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.3\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83;                       Permissions: users-full
Source: "modules\PHP-7.2-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-7.2-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72fcgi;                   Permissions: users-full
Source: "modules\PHP-7.3-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-7.3-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73fcgi;                   Permissions: users-full
Source: "modules\PHP-7.4-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-7.4-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74fcgi;                   Permissions: users-full
Source: "modules\PHP-8.0-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.0-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80fcgi;                   Permissions: users-full
Source: "modules\PHP-8.1-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.1-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81fcgi;                   Permissions: users-full
Source: "modules\PHP-8.2-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.2-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82fcgi;                   Permissions: users-full
Source: "modules\PHP-8.3-FCGI\ospanel_data\default\*";            DestDir: "{app}\config\PHP-8.3-FCGI\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php83fcgi;                   Permissions: users-full

Source: "modules\MySQL-5.5\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-5.5\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: mysql\mysql55;         Permissions: users-full
Source: "modules\MySQL-5.6\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-5.6\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql56;                   Permissions: users-full
Source: "modules\MySQL-5.7\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-5.7\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql57;                   Permissions: users-full
Source: "modules\MySQL-8.0\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-8.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql80;                   Permissions: users-full
Source: "modules\MySQL-8.2\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-8.2\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mysql\mysql82;                   Permissions: users-full

Source: "modules\MariaDB-10.1\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.1\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb101;              Permissions: users-full
Source: "modules\MariaDB-10.2\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.2\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb102;              Permissions: users-full
Source: "modules\MariaDB-10.3\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.3\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb103;              Permissions: users-full
Source: "modules\MariaDB-10.4\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.4\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb104;              Permissions: users-full
Source: "modules\MariaDB-10.5\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.5\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb105;              Permissions: users-full
Source: "modules\MariaDB-10.6\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.6\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb106;              Permissions: users-full
Source: "modules\MariaDB-10.7\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.7\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb107;              Permissions: users-full
Source: "modules\MariaDB-10.8\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.8\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb108;              Permissions: users-full
Source: "modules\MariaDB-10.9\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.9\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb109;              Permissions: users-full
Source: "modules\MariaDB-10.10\ospanel_data\default\*";           DestDir: "{app}\config\MariaDB-10.10\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb1010;             Permissions: users-full
Source: "modules\MariaDB-10.11\ospanel_data\default\*";           DestDir: "{app}\config\MariaDB-10.11\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb1011;             Permissions: users-full
Source: "modules\MariaDB-11.0\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.0\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb110;              Permissions: users-full
Source: "modules\MariaDB-11.1\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.1\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb111;              Permissions: users-full
Source: "modules\MariaDB-11.2\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.2\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mariadb\mariadb112;              Permissions: users-full

Source: "modules\PostgreSQL-9.5\ospanel_data\default\*";          DestDir: "{app}\config\PostgreSQL-9.5\default"; Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: psql\postgresql95;     Permissions: users-full
Source: "modules\PostgreSQL-9.6\ospanel_data\default\*";          DestDir: "{app}\config\PostgreSQL-9.6\default"; Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql96;               Permissions: users-full
Source: "modules\PostgreSQL-10\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-10\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql10;               Permissions: users-full
Source: "modules\PostgreSQL-11\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-11\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql11;               Permissions: users-full
Source: "modules\PostgreSQL-12\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-12\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql12;               Permissions: users-full
Source: "modules\PostgreSQL-13\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-13\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql13;               Permissions: users-full
Source: "modules\PostgreSQL-14\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-14\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql14;               Permissions: users-full
Source: "modules\PostgreSQL-15\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-15\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql15;               Permissions: users-full
Source: "modules\PostgreSQL-16\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-16\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql16;               Permissions: users-full

Source: "modules\MongoDB-3.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-3.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: mongodb\mongodb30;     Permissions: users-full
Source: "modules\MongoDB-3.2\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-3.2\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb32;               Permissions: users-full
Source: "modules\MongoDB-3.4\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-3.4\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb34;               Permissions: users-full
Source: "modules\MongoDB-3.6\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-3.6\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb36;               Permissions: users-full
Source: "modules\MongoDB-4.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb40;               Permissions: users-full
Source: "modules\MongoDB-4.2\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.2\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb42;               Permissions: users-full
Source: "modules\MongoDB-4.4\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.4\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb44;               Permissions: users-full
Source: "modules\MongoDB-5.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-5.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb50;               Permissions: users-full
Source: "modules\MongoDB-6.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-6.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb60;               Permissions: users-full
Source: "modules\MongoDB-7.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-7.0\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongodb\mongodb70;               Permissions: users-full

Source: "modules\Memcached-1.4\ospanel_data\default\*";           DestDir: "{app}\config\Memcached-1.4\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: memcached\memcached14; Permissions: users-full
Source: "modules\Memcached-1.6\ospanel_data\default\*";           DestDir: "{app}\config\Memcached-1.6\default";  Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: memcached\memcached16;           Permissions: users-full

Source: "modules\Redis-3.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-3.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis30;                   Permissions: users-full
Source: "modules\Redis-3.2\ospanel_data\default\*";               DestDir: "{app}\config\Redis-3.2\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis32;                   Permissions: users-full
Source: "modules\Redis-4.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-4.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis40;                   Permissions: users-full
Source: "modules\Redis-5.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-5.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis50;                   Permissions: users-full
Source: "modules\Redis-7.0\ospanel_data\default\*";               DestDir: "{app}\config\Redis-7.0\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis70;                   Permissions: users-full
Source: "modules\Redis-7.2\ospanel_data\default\*";               DestDir: "{app}\config\Redis-7.2\default";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis72;                   Permissions: users-full

Source: "modules\Bind\ospanel_data\default\*";                    DestDir: "{app}\config\Bind\default";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: dns\bind;                        Permissions: users-full
Source: "modules\Unbound\ospanel_data\default\*";                 DestDir: "{app}\config\Unbound\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: dns\unbound;                     Permissions: users-full

Source: "modules\Nginx-1.22\ospanel_data\default\*";              DestDir: "{app}\config\Nginx-1.22\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: nginx\nginx122;                  Permissions: users-full
Source: "modules\Nginx-1.25\ospanel_data\default\*";              DestDir: "{app}\config\Nginx-1.25\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: nginx\nginx125;                  Permissions: users-full

Source: "modules\PHP-7.2\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.2\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite solidbreak;  Components: php\php72;         Permissions: users-full
Source: "modules\PHP-7.3\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.3\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php73;                    Permissions: users-full
Source: "modules\PHP-7.4\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.4\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php74;                    Permissions: users-full
Source: "modules\PHP-8.0\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.0\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php80;                    Permissions: users-full
Source: "modules\PHP-8.1\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.1\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php81;                    Permissions: users-full
Source: "modules\PHP-8.2\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.2\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php82;                    Permissions: users-full
Source: "modules\PHP-8.3\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.3\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php83;                    Permissions: users-full
Source: "modules\PHP-7.2-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-7.2-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php72fcgi;                Permissions: users-full
Source: "modules\PHP-7.3-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-7.3-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php73fcgi;                Permissions: users-full
Source: "modules\PHP-7.4-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-7.4-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php74fcgi;                Permissions: users-full
Source: "modules\PHP-8.0-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.0-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php80fcgi;                Permissions: users-full
Source: "modules\PHP-8.1-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.1-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php81fcgi;                Permissions: users-full
Source: "modules\PHP-8.2-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.2-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php82fcgi;                Permissions: users-full
Source: "modules\PHP-8.3-FCGI\ospanel_data\default_data\*";       DestDir: "{app}\data\PHP-8.3-FCGI\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: php\php83fcgi;                Permissions: users-full

Source: "modules\Bind\ospanel_data\default_data\*";               DestDir: "{app}\data\Bind\default";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: dns\bind;                     Permissions: users-full
Source: "modules\Unbound\ospanel_data\default_data\*";            DestDir: "{app}\data\Unbound\default";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: dns\unbound;                  Permissions: users-full

Source: "modules\MySQL-5.5\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-5.5\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite solidbreak; Components: mysql\mysql55;      Permissions: users-full
Source: "modules\MySQL-5.6\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-5.6\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mysql\mysql56;                Permissions: users-full
Source: "modules\MySQL-5.7\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-5.7\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mysql\mysql57;                Permissions: users-full
Source: "modules\MySQL-8.0\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-8.0\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mysql\mysql80;                Permissions: users-full
Source: "modules\MySQL-8.2\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-8.2\default";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mysql\mysql82;                Permissions: users-full

Source: "modules\MariaDB-10.1\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.1\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb101;           Permissions: users-full
Source: "modules\MariaDB-10.2\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.2\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb102;           Permissions: users-full
Source: "modules\MariaDB-10.3\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.3\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb103;           Permissions: users-full
Source: "modules\MariaDB-10.4\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.4\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb104;           Permissions: users-full
Source: "modules\MariaDB-10.5\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.5\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb105;           Permissions: users-full
Source: "modules\MariaDB-10.6\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.6\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb106;           Permissions: users-full
Source: "modules\MariaDB-10.7\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.7\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb107;           Permissions: users-full
Source: "modules\MariaDB-10.8\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.8\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb108;           Permissions: users-full
Source: "modules\MariaDB-10.9\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.9\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb109;           Permissions: users-full
Source: "modules\MariaDB-10.10\ospanel_data\default_data\*";      DestDir: "{app}\data\MariaDB-10.10\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb1010;          Permissions: users-full
Source: "modules\MariaDB-10.11\ospanel_data\default_data\*";      DestDir: "{app}\data\MariaDB-10.11\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb1011;          Permissions: users-full
Source: "modules\MariaDB-11.0\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.0\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb110;           Permissions: users-full
Source: "modules\MariaDB-11.1\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.1\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb111;           Permissions: users-full
Source: "modules\MariaDB-11.2\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.2\default";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: mariadb\mariadb112;           Permissions: users-full

Source: "modules\PostgreSQL-9.5\ospanel_data\default_data\*";     DestDir: "{app}\data\PostgreSQL-9.5\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite solidbreak; Components: psql\postgresql95;  Permissions: users-full
Source: "modules\PostgreSQL-9.6\ospanel_data\default_data\*";     DestDir: "{app}\data\PostgreSQL-9.6\default";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql96;            Permissions: users-full
Source: "modules\PostgreSQL-10\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-10\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql10;            Permissions: users-full
Source: "modules\PostgreSQL-11\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-11\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql11;            Permissions: users-full
Source: "modules\PostgreSQL-12\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-12\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql12;            Permissions: users-full
Source: "modules\PostgreSQL-13\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-13\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql13;            Permissions: users-full
Source: "modules\PostgreSQL-14\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-14\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql14;            Permissions: users-full
Source: "modules\PostgreSQL-15\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-15\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql15;            Permissions: users-full
Source: "modules\PostgreSQL-16\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-16\default";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite;  Components: psql\postgresql16;            Permissions: users-full

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
            WizardForm.TasksList.Checked[2] := false;
            WizardForm.TasksList.ItemEnabled[0] := false;  
            WizardForm.TasksList.ItemEnabled[1] := false;
            WizardForm.TasksList.ItemEnabled[2] := false;
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
