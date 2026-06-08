#define AppVersion      ""
#define AppVersion_     ""
#define AppDomain       "ospanel.io"
#define AppTitle        "Open Server Panel"
#define CurrentYear     GetDateTimeString('yyyy', '', '')

#define FO_FLAGS        "sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite"
#define STD_FLAGS       "sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite"
#define STD_SFLAGS      "sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak"
#define NUN_FLAGS       "sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite"    
#define NUN_SFLAGS      "sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs uninsneveruninstall confirmoverwrite solidbreak"


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

// Compression          = lzma2/fast
Compression             = lzma2/ultra64
InternalCompressLevel   = ultra64
LZMAUseSeparateProcess  = yes
SolidCompression        = yes
LZMABlockSize           = 262144
LZMADictionarySize      = 262144
LZMANumBlockThreads     = 4
LZMANumFastBytes        = 273
// LZMANumFastBytes     = 32

// Misc  

AllowNoIcons            = yes
AllowRootDirectory      = yes
AllowUNCPath            = no
AppMutex                = Global\OSPanel
ArchitecturesAllowed    = x64os
ArchitecturesInstallIn64BitMode = x64os
ChangesEnvironment      = yes
CloseApplications       = no
DefaultDirName          = {sd}\OSPanel
DefaultGroupName        = {#AppTitle}
DisableDirPage          = no
DisableProgramGroupPage = no
DisableReadyPage        = no
DisableStartupPrompt    = yes
DisableWelcomePage      = no
MinVersion              = 10.0.10240
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

Name: "en";             MessagesFile: "resources\lang\en.isl";    LicenseFile: "resources\lang\license.en.txt"; InfoBeforeFile: "resources\lang\en.txt"
Name: "ru";             MessagesFile: "resources\lang\ru.isl";    LicenseFile: "resources\lang\license.ru.txt"; InfoBeforeFile: "resources\lang\ru.txt"
Name: "ua";             MessagesFile: "resources\lang\ua.isl";    LicenseFile: "resources\lang\license.ua.txt"; InfoBeforeFile: "resources\lang\ua.txt"
Name: "be";             MessagesFile: "resources\lang\be.isl";    LicenseFile: "resources\lang\license.be.txt"; InfoBeforeFile: "resources\lang\be.txt"

[Tasks]

Name: "desktop_icon";   Description:  "{cm:CreateDesktopIcon}";                      Components: core
Name: "add_to_path";    Description:  "{cm:AddToPath}";                              Components: core
Name: "import_cert";    Description:  "{cm:ImportCert}";                             Components: core

[Icons]

Name: "{group}\{#AppTitle}";              Filename: "{app}\bin\ospanel.exe";            WorkingDir: "{app}";      Components: core;                 Flags: createonlyiffileexists
Name: "{group}\System Preparation Tool";  Filename: "{app}\system\bin\syspreptool.exe"; WorkingDir: "{app}";      Components: core;                 Flags: createonlyiffileexists
Name: "{group}\{cm:RunManual}";           Filename: "https://github.com/OSPanel/OpenServerPanel/wiki";            Components: core;                 Languages: en
Name: "{group}\{cm:RunManual}";           Filename: "https://github.com/OSPanel/OpenServerPanel/wiki/%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F"; Components: core; Languages: ru ua be
Name: "{group}\{cm:RunDonate}";           Filename: "https://ospanel.io/donate/";                                 Components: core
Name: "{group}\{cm:UninstallProgram,{#AppTitle}}"; Filename: "{uninstallexe}";          WorkingDir: "{app}";      Components: core;                 Flags: createonlyiffileexists
Name: "{autodesktop}\{#AppTitle}";        Filename: "{app}\bin\ospanel.exe";            WorkingDir: "{app}";      Flags: createonlyiffileexists;    Tasks: desktop_icon

[Components]

Name: "core";                          Description: "{cm:CoreData}";         Types: full compact;                 Flags: disablenouninstallwarning

Name: "addons";                        Description: "{cm:SubAddons}";                                             Flags: disablenouninstallwarning

Name: "addons\db2odbc";                Description: "DB2 ODBC 12.1";                      Types: full;            Flags: disablenouninstallwarning
Name: "addons\ffmpeg";                 Description: "FFMpeg 7.1";                         Types: full;            Flags: disablenouninstallwarning
Name: "addons\gs";                     Description: "Ghostscript 10.05";                  Types: full compact;    Flags: disablenouninstallwarning
Name: "addons\go";                     Description: "Go programming language 1.25";       Types: full;            Flags: disablenouninstallwarning

Name: "addons\imagick";                Description: "ImageMagick";
Name: "addons\imagick\im15";           Description: "ImageMagick 7.1 VC15 (PHP 7.x)";     Types: full;            Flags: disablenouninstallwarning
Name: "addons\imagick\im16";           Description: "ImageMagick 7.1 VS16 (PHP 8.0-8.3)"; Types: full compact;    Flags: disablenouninstallwarning
Name: "addons\imagick\im17";           Description: "ImageMagick 7.1 VS17 (PHP 8.4+)";    Types: full compact;    Flags: disablenouninstallwarning

Name: "addons\libwebp";                Description: "Libwebp 1.6";                        Types: full compact;    Flags: disablenouninstallwarning
Name: "addons\oic";                    Description: "Oracle Instant Client 23";           Types: full;            Flags: disablenouninstallwarning

Name: "addons\erlang";                 Description: "{cm:RabbitMQAddons}";
Name: "addons\erlang\erlang26";        Description: "Erlang/OTP 26.2 (RabbitMQ 3.x)";     Types: full;            Flags: disablenouninstallwarning
Name: "addons\erlang\erlang27";        Description: "Erlang/OTP 27.3 (RabbitMQ 4.x)";     Types: full;            Flags: disablenouninstallwarning

Name: "addons\mongo";                  Description: "{cm:MongoDBAddons}";
Name: "addons\mongo\mongotools";       Description: "MongoDB Tools 100.14";               Types: full;            Flags: disablenouninstallwarning
Name: "addons\mongo\mongoshell";       Description: "MongoDB Shell 2.5";                  Types: full;            Flags: disablenouninstallwarning

Name: "addons\nvm";                    Description: "{cm:NodeJSVersionManager} 1.1";      Types: full compact;    Flags: disablenouninstallwarning


Name: "modules";                       Description: "{cm:SubModules}";                                            Flags: disablenouninstallwarning

Name: "modules\blackfire";             Description: "Blackfire 2.30";        Types: full;                         Flags: disablenouninstallwarning

Name: "modules\dns";                   Description: "DNS";                                                        Flags: disablenouninstallwarning
Name: "modules\dns\bind";              Description: "Bind 9.17";             Types: full;                         Flags: disablenouninstallwarning
Name: "modules\dns\unbound";           Description: "Unbound 1.24";          Types: full;                         Flags: disablenouninstallwarning

Name: "modules\web";                   Description: "HTTP";
Name: "modules\web\apache";            Description: "Apache 2.4";            Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\web\caddy";             Description: "Caddy 2.10";            Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\web\nginx";             Description: "Nginx 1.29";            Types: full compact;                 Flags: disablenouninstallwarning

Name: "modules\mail";                  Description: "Mail";                                                       Flags: disablenouninstallwarning
Name: "modules\mail\mailpit";          Description: "Mailpit 1.28";          Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\mail\smtp4dev";         Description: "Smtp4dev 3.12";         Types: full compact;                 Flags: disablenouninstallwarning

Name: "modules\mariadb";               Description: "MariaDB";                                                    Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb104";    Description: "MariaDB 10.4";          Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb105";    Description: "MariaDB 10.5";          Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb106";    Description: "MariaDB 10.6";          Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb1011";   Description: "MariaDB 10.11";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb114";    Description: "MariaDB 11.4";          Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mariadb\mariadb118";    Description: "MariaDB 11.8";          Types: full compact;                 Flags: disablenouninstallwarning

Name: "modules\memcached";             Description: "Memcached 1.6";         Types: full compact;                 Flags: disablenouninstallwarning

Name: "modules\mongodb";               Description: "MongoDB";                                                    Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb40";     Description: "MongoDB 4.0";           Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb42";     Description: "MongoDB 4.2";           Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb44";     Description: "MongoDB 4.4";           Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb50";     Description: "MongoDB 5.0";           Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb60";     Description: "MongoDB 6.0";           Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb70";     Description: "MongoDB 7.0";           Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb80";     Description: "MongoDB 8.0";           Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mongodb\mongodb82";     Description: "MongoDB 8.2";           Types: full;                         Flags: disablenouninstallwarning

Name: "modules\mysql";                 Description: "MySQL";                                                      Flags: disablenouninstallwarning
Name: "modules\mysql\mysql57";         Description: "MySQL 5.7";             Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\mysql\mysql80";         Description: "MySQL 8.0";             Types: full;                         Flags: disablenouninstallwarning
Name: "modules\mysql\mysql84";         Description: "MySQL 8.4";             Types: full compact;                 Flags: disablenouninstallwarning

Name: "modules\php";                   Description: "PHP";                                                        Flags: disablenouninstallwarning
Name: "modules\php\php72";             Description: "PHP 7.2 VC15 NTS";      Types: full;                         Flags: disablenouninstallwarning
Name: "modules\php\php73";             Description: "PHP 7.3 VC15 NTS";      Types: full;                         Flags: disablenouninstallwarning
Name: "modules\php\php74";             Description: "PHP 7.4 VC15 NTS";      Types: full;                         Flags: disablenouninstallwarning
Name: "modules\php\php80";             Description: "PHP 8.0 VS16 NTS";      Types: full;                         Flags: disablenouninstallwarning
Name: "modules\php\php81";             Description: "PHP 8.1 VS16 NTS";      Types: full;                         Flags: disablenouninstallwarning
Name: "modules\php\php82";             Description: "PHP 8.2 VS16 NTS";      Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\php\php83";             Description: "PHP 8.3 VS16 NTS";      Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\php\php84";             Description: "PHP 8.4 VS17 NTS";      Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\php\php85";             Description: "PHP 8.5 VS17 NTS";      Types: full compact;                 Flags: disablenouninstallwarning

Name: "modules\pocketbase";            Description: "PocketBase 0.36";       Types: full compact;                 Flags: disablenouninstallwarning

Name: "modules\psql";                  Description: "PostgreSQL";                                                 Flags: disablenouninstallwarning
Name: "modules\psql\postgresql11";     Description: "PostgreSQL 11";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql12";     Description: "PostgreSQL 12";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql13";     Description: "PostgreSQL 13";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql14";     Description: "PostgreSQL 14";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql15";     Description: "PostgreSQL 15";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql16";     Description: "PostgreSQL 16";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql17";     Description: "PostgreSQL 17";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\psql\postgresql18";     Description: "PostgreSQL 18";         Types: full;                         Flags: disablenouninstallwarning

Name: "modules\rabbitmq";              Description: "RabbitMQ";                                                   Flags: disablenouninstallwarning
Name: "modules\rabbitmq\rabbitmq313";  Description: "RabbitMQ 3.13";         Types: full;                         Flags: disablenouninstallwarning
Name: "modules\rabbitmq\rabbitmq40";   Description: "RabbitMQ 4.0";          Types: full;                         Flags: disablenouninstallwarning
Name: "modules\rabbitmq\rabbitmq41";   Description: "RabbitMQ 4.1";          Types: full;                         Flags: disablenouninstallwarning
Name: "modules\rabbitmq\rabbitmq42";   Description: "RabbitMQ 4.2";          Types: full;                         Flags: disablenouninstallwarning

Name: "modules\redis";                 Description: "Redis 8.4";             Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\sftpgo";                Description: "SFTPGo 2.7";            Types: full compact;                 Flags: disablenouninstallwarning
Name: "modules\vault";                 Description: "Vault 1.21";            Types: full;                         Flags: disablenouninstallwarning

[Dirs]

Name: "{app}\home\full-example.local\.osp\backup";                Components: core;      Permissions: users-full; Flags: uninsneveruninstall
Name: "{app}\system\skeleton_full\backup";                        Components: core;      Permissions: users-full
Name: "{app}\system\skeleton_full\apache";                        Components: core;      Permissions: users-full
Name: "{app}\system\skeleton_full\nginx";                         Components: core;      Permissions: users-full
Name: "{app}\system\skeleton_full\caddy";                         Components: core;      Permissions: users-full
Name: "{app}\addons\Go\workspace";                                Components: addons\go; Permissions: users-full; Flags: uninsneveruninstall                   
Name: "{app}\addons\Go\workspace\pkg";                            Components: addons\go; Permissions: users-full; Flags: uninsneveruninstall
Name: "{app}\addons\Go\workspace\pkg\mod";                        Components: addons\go; Permissions: users-full
Name: "{app}\addons\Go\workspace\bin";                            Components: addons\go; Permissions: users-full; Flags: uninsneveruninstall
Name: "{app}\addons\Go\workspace\src";                            Components: addons\go; Permissions: users-full; Flags: uninsneveruninstall
Name: "{app}\addons\Go\workspace\cache";                          Components: addons\go; Permissions: users-full

[Files]

Source: "resources\dist\CheckSSE42.dll";                                                                          Flags: dontcopy
Source: "system\default\menu.dat";     DestName: "menu.dat";      DestDir: "{app}\system";                        Flags: {#FO_FLAGS};   Components: core;                            Permissions: users-full
Source: "system\default\program.dat";  DestName: "program.dat";   DestDir: "{app}\system";                        Flags: {#FO_FLAGS};   Components: core;                            Permissions: users-full
Source: "licenses\*";                                             DestDir: "{app}\licenses";                      Flags: {#STD_FLAGS};  Components: core;                            Permissions: users-full
Source: "bin\*";                                                  DestDir: "{app}\bin";                           Flags: {#STD_FLAGS};  Components: core;                            Permissions: users-full
Source: "home\*";                                                 DestDir: "{app}\home";                          Flags: {#NUN_FLAGS};  Components: core;                            Permissions: users-full
Source: "system\*";                                               DestDir: "{app}\system";                        Flags: {#STD_FLAGS};  Components: core;                            Permissions: users-full
Source: "user\*";                                                 DestDir: "{app}\user";                          Flags: {#STD_FLAGS};  Components: core;                            Permissions: users-full
Source: "addons\DB2-ODBC\*";                                      DestDir: "{app}\addons\DB2-ODBC";               Flags: {#STD_SFLAGS}; Components: addons\db2odbc;                  Permissions: users-full
Source: "addons\FFMpeg\*";                                        DestDir: "{app}\addons\FFMpeg";                 Flags: {#STD_FLAGS};  Components: addons\ffmpeg;                   Permissions: users-full
Source: "addons\Ghostscript\*";                                   DestDir: "{app}\addons\Ghostscript";            Flags: {#STD_FLAGS};  Components: addons\gs;                       Permissions: users-full
Source: "addons\Go\*";                                            DestDir: "{app}\addons\Go";                     Flags: {#STD_FLAGS};  Components: addons\go;                       Permissions: users-full
Source: "addons\ImageMagick-vc15\*";                              DestDir: "{app}\addons\ImageMagick-vc15";       Flags: {#STD_FLAGS};  Components: addons\imagick\im15;             Permissions: users-full
Source: "addons\ImageMagick-vs16\*";                              DestDir: "{app}\addons\ImageMagick-vs16";       Flags: {#STD_FLAGS};  Components: addons\imagick\im16;             Permissions: users-full
Source: "addons\ImageMagick-vs17\*";                              DestDir: "{app}\addons\ImageMagick-vs17";       Flags: {#STD_FLAGS};  Components: addons\imagick\im17;             Permissions: users-full
Source: "addons\InstantClient\*";                                 DestDir: "{app}\addons\InstantClient";          Flags: {#STD_FLAGS};  Components: addons\oic;                      Permissions: users-full
Source: "addons\Libwebp\*";                                       DestDir: "{app}\addons\Libwebp";                Flags: {#STD_FLAGS};  Components: addons\libwebp;                  Permissions: users-full
Source: "addons\MongoShell\*";                                    DestDir: "{app}\addons\MongoShell";             Flags: {#STD_FLAGS};  Components: addons\mongo\mongoshell;         Permissions: users-full
Source: "addons\MongoTools\*";                                    DestDir: "{app}\addons\MongoTools";             Flags: {#STD_FLAGS};  Components: addons\mongo\mongotools;         Permissions: users-full
Source: "addons\NVM\*";                                           DestDir: "{app}\addons\NVM";                    Flags: {#STD_FLAGS};  Components: addons\nvm;                      Permissions: users-full
Source: "addons\ErlangOTP-26\*";                                  DestDir: "{app}\addons\ErlangOTP-26";           Flags: {#STD_FLAGS};  Components: addons\erlang\erlang26;          Permissions: users-full
Source: "addons\ErlangOTP-27\*";                                  DestDir: "{app}\addons\ErlangOTP-27";           Flags: {#STD_FLAGS};  Components: addons\erlang\erlang27;          Permissions: users-full

Source: "modules\PHP-7.2\*";                                      DestDir: "{app}\modules\PHP-7.2";               Flags: {#STD_SFLAGS}; Components: modules\php\php72;               Permissions: users-full
Source: "modules\PHP-7.3\*";                                      DestDir: "{app}\modules\PHP-7.3";               Flags: {#STD_FLAGS};  Components: modules\php\php73;               Permissions: users-full
Source: "modules\PHP-7.4\*";                                      DestDir: "{app}\modules\PHP-7.4";               Flags: {#STD_FLAGS};  Components: modules\php\php74;               Permissions: users-full
Source: "modules\PHP-8.0\*";                                      DestDir: "{app}\modules\PHP-8.0";               Flags: {#STD_FLAGS};  Components: modules\php\php80;               Permissions: users-full
Source: "modules\PHP-8.1\*";                                      DestDir: "{app}\modules\PHP-8.1";               Flags: {#STD_FLAGS};  Components: modules\php\php81;               Permissions: users-full
Source: "modules\PHP-8.2\*";                                      DestDir: "{app}\modules\PHP-8.2";               Flags: {#STD_FLAGS};  Components: modules\php\php82;               Permissions: users-full
Source: "modules\PHP-8.3\*";                                      DestDir: "{app}\modules\PHP-8.3";               Flags: {#STD_FLAGS};  Components: modules\php\php83;               Permissions: users-full
Source: "modules\PHP-8.4\*";                                      DestDir: "{app}\modules\PHP-8.4";               Flags: {#STD_FLAGS};  Components: modules\php\php84;               Permissions: users-full
Source: "modules\PHP-8.5\*";                                      DestDir: "{app}\modules\PHP-8.5";               Flags: {#STD_FLAGS};  Components: modules\php\php85;               Permissions: users-full

Source: "modules\MySQL-5.7\*";                                    DestDir: "{app}\modules\MySQL-5.7";             Flags: {#STD_SFLAGS}; Components: modules\mysql\mysql57;           Permissions: users-full
Source: "modules\MySQL-8.0\*";                                    DestDir: "{app}\modules\MySQL-8.0";             Flags: {#STD_FLAGS};  Components: modules\mysql\mysql80;           Permissions: users-full
Source: "modules\MySQL-8.4\*";                                    DestDir: "{app}\modules\MySQL-8.4";             Flags: {#STD_FLAGS};  Components: modules\mysql\mysql84;           Permissions: users-full

Source: "modules\MariaDB-10.4\*";                                 DestDir: "{app}\modules\MariaDB-10.4";          Flags: {#STD_SFLAGS}; Components: modules\mariadb\mariadb104;      Permissions: users-full
Source: "modules\MariaDB-10.5\*";                                 DestDir: "{app}\modules\MariaDB-10.5";          Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb105;      Permissions: users-full
Source: "modules\MariaDB-10.6\*";                                 DestDir: "{app}\modules\MariaDB-10.6";          Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb106;      Permissions: users-full
Source: "modules\MariaDB-10.11\*";                                DestDir: "{app}\modules\MariaDB-10.11";         Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb1011;     Permissions: users-full
Source: "modules\MariaDB-11.4\*";                                 DestDir: "{app}\modules\MariaDB-11.4";          Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb114;      Permissions: users-full
Source: "modules\MariaDB-11.8\*";                                 DestDir: "{app}\modules\MariaDB-11.8";          Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb118;      Permissions: users-full

Source: "modules\PostgreSQL-11\*";                                DestDir: "{app}\modules\PostgreSQL-11";         Flags: {#STD_SFLAGS}; Components: modules\psql\postgresql11;       Permissions: users-full
Source: "modules\PostgreSQL-12\*";                                DestDir: "{app}\modules\PostgreSQL-12";         Flags: {#STD_FLAGS};  Components: modules\psql\postgresql12;       Permissions: users-full
Source: "modules\PostgreSQL-13\*";                                DestDir: "{app}\modules\PostgreSQL-13";         Flags: {#STD_FLAGS};  Components: modules\psql\postgresql13;       Permissions: users-full
Source: "modules\PostgreSQL-14\*";                                DestDir: "{app}\modules\PostgreSQL-14";         Flags: {#STD_FLAGS};  Components: modules\psql\postgresql14;       Permissions: users-full
Source: "modules\PostgreSQL-15\*";                                DestDir: "{app}\modules\PostgreSQL-15";         Flags: {#STD_FLAGS};  Components: modules\psql\postgresql15;       Permissions: users-full
Source: "modules\PostgreSQL-16\*";                                DestDir: "{app}\modules\PostgreSQL-16";         Flags: {#STD_FLAGS};  Components: modules\psql\postgresql16;       Permissions: users-full
Source: "modules\PostgreSQL-17\*";                                DestDir: "{app}\modules\PostgreSQL-17";         Flags: {#STD_FLAGS};  Components: modules\psql\postgresql17;       Permissions: users-full
Source: "modules\PostgreSQL-18\*";                                DestDir: "{app}\modules\PostgreSQL-18";         Flags: {#STD_FLAGS};  Components: modules\psql\postgresql18;       Permissions: users-full

Source: "modules\MongoDB-4.0\*";                                  DestDir: "{app}\modules\MongoDB-4.0";           Flags: {#STD_SFLAGS}; Components: modules\mongodb\mongodb40;       Permissions: users-full
Source: "modules\MongoDB-4.2\*";                                  DestDir: "{app}\modules\MongoDB-4.2";           Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb42;       Permissions: users-full
Source: "modules\MongoDB-4.4\*";                                  DestDir: "{app}\modules\MongoDB-4.4";           Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb44;       Permissions: users-full
Source: "modules\MongoDB-5.0\*";                                  DestDir: "{app}\modules\MongoDB-5.0";           Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb50;       Permissions: users-full
Source: "modules\MongoDB-6.0\*";                                  DestDir: "{app}\modules\MongoDB-6.0";           Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb60;       Permissions: users-full
Source: "modules\MongoDB-7.0\*";                                  DestDir: "{app}\modules\MongoDB-7.0";           Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb70;       Permissions: users-full
Source: "modules\MongoDB-8.0\*";                                  DestDir: "{app}\modules\MongoDB-8.0";           Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb80;       Permissions: users-full
Source: "modules\MongoDB-8.2\*";                                  DestDir: "{app}\modules\MongoDB-8.2";           Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb82;       Permissions: users-full

Source: "modules\Bind\*";                                         DestDir: "{app}\modules\Bind";                  Flags: {#STD_SFLAGS}; Components: modules\dns\bind;                Permissions: users-full
Source: "modules\Blackfire\*";                                    DestDir: "{app}\modules\Blackfire";             Flags: {#STD_FLAGS};  Components: modules\blackfire;               Permissions: users-full
Source: "modules\Mailpit\*";                                      DestDir: "{app}\modules\Mailpit";               Flags: {#STD_FLAGS};  Components: modules\mail\mailpit;            Permissions: users-full
Source: "modules\Memcached\*";                                    DestDir: "{app}\modules\Memcached";             Flags: {#STD_FLAGS};  Components: modules\memcached;               Permissions: users-full
Source: "modules\Apache\*";                                       DestDir: "{app}\modules\Apache";                Flags: {#STD_FLAGS};  Components: modules\web\apache;              Permissions: users-full
Source: "modules\Caddy\*";                                        DestDir: "{app}\modules\Caddy";                 Flags: {#STD_FLAGS};  Components: modules\web\caddy;               Permissions: users-full
Source: "modules\Nginx\*";                                        DestDir: "{app}\modules\Nginx";                 Flags: {#STD_FLAGS};  Components: modules\web\nginx;               Permissions: users-full
Source: "modules\PocketBase\*";                                   DestDir: "{app}\modules\PocketBase";            Flags: {#STD_FLAGS};  Components: modules\pocketbase;              Permissions: users-full
Source: "modules\RabbitMQ-3.13\*";                                DestDir: "{app}\modules\RabbitMQ-3.13";         Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq313;    Permissions: users-full
Source: "modules\RabbitMQ-4.0\*";                                 DestDir: "{app}\modules\RabbitMQ-4.0";          Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq40;     Permissions: users-full
Source: "modules\RabbitMQ-4.1\*";                                 DestDir: "{app}\modules\RabbitMQ-4.1";          Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq41;     Permissions: users-full
Source: "modules\RabbitMQ-4.2\*";                                 DestDir: "{app}\modules\RabbitMQ-4.2";          Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq42;     Permissions: users-full
Source: "modules\Redis\*";                                        DestDir: "{app}\modules\Redis";                 Flags: {#STD_FLAGS};  Components: modules\redis;                   Permissions: users-full
Source: "modules\SFTPGo\*";                                       DestDir: "{app}\modules\SFTPGo";                Flags: {#STD_FLAGS};  Components: modules\sftpgo;                  Permissions: users-full
Source: "modules\Smtp4dev\*";                                     DestDir: "{app}\modules\Smtp4dev";              Flags: {#STD_FLAGS};  Components: modules\mail\smtp4dev;           Permissions: users-full
Source: "modules\Unbound\*";                                      DestDir: "{app}\modules\Unbound";               Flags: {#STD_FLAGS};  Components: modules\dns\unbound;             Permissions: users-full
Source: "modules\Vault\*";                                        DestDir: "{app}\modules\Vault";                 Flags: {#STD_FLAGS};  Components: modules\vault;                   Permissions: users-full

Source: "modules\PHP-7.2\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.2\default";        Flags: {#STD_SFLAGS}; Components: modules\php\php72;               Permissions: users-full
Source: "modules\PHP-7.3\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.3\default";        Flags: {#STD_FLAGS};  Components: modules\php\php73;               Permissions: users-full
Source: "modules\PHP-7.4\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-7.4\default";        Flags: {#STD_FLAGS};  Components: modules\php\php74;               Permissions: users-full
Source: "modules\PHP-8.0\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.0\default";        Flags: {#STD_FLAGS};  Components: modules\php\php80;               Permissions: users-full
Source: "modules\PHP-8.1\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.1\default";        Flags: {#STD_FLAGS};  Components: modules\php\php81;               Permissions: users-full
Source: "modules\PHP-8.2\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.2\default";        Flags: {#STD_FLAGS};  Components: modules\php\php82;               Permissions: users-full
Source: "modules\PHP-8.3\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.3\default";        Flags: {#STD_FLAGS};  Components: modules\php\php83;               Permissions: users-full
Source: "modules\PHP-8.4\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.4\default";        Flags: {#STD_FLAGS};  Components: modules\php\php84;               Permissions: users-full
Source: "modules\PHP-8.5\ospanel_data\default\*";                 DestDir: "{app}\config\PHP-8.5\default";        Flags: {#STD_FLAGS};  Components: modules\php\php85;               Permissions: users-full

Source: "modules\MySQL-5.7\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-5.7\default";      Flags: {#STD_SFLAGS}; Components: modules\mysql\mysql57;           Permissions: users-full
Source: "modules\MySQL-8.0\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-8.0\default";      Flags: {#STD_FLAGS};  Components: modules\mysql\mysql80;           Permissions: users-full
Source: "modules\MySQL-8.4\ospanel_data\default\*";               DestDir: "{app}\config\MySQL-8.4\default";      Flags: {#STD_FLAGS};  Components: modules\mysql\mysql84;           Permissions: users-full

Source: "modules\MariaDB-10.4\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.4\default";   Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb104;      Permissions: users-full
Source: "modules\MariaDB-10.5\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.5\default";   Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb105;      Permissions: users-full
Source: "modules\MariaDB-10.6\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-10.6\default";   Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb106;      Permissions: users-full
Source: "modules\MariaDB-10.11\ospanel_data\default\*";           DestDir: "{app}\config\MariaDB-10.11\default";  Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb1011;     Permissions: users-full
Source: "modules\MariaDB-11.4\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.4\default";   Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb114;      Permissions: users-full
Source: "modules\MariaDB-11.8\ospanel_data\default\*";            DestDir: "{app}\config\MariaDB-11.8\default";   Flags: {#STD_FLAGS};  Components: modules\mariadb\mariadb118;      Permissions: users-full

Source: "modules\PostgreSQL-11\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-11\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql11;       Permissions: users-full
Source: "modules\PostgreSQL-12\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-12\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql12;       Permissions: users-full
Source: "modules\PostgreSQL-13\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-13\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql13;       Permissions: users-full
Source: "modules\PostgreSQL-14\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-14\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql14;       Permissions: users-full
Source: "modules\PostgreSQL-15\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-15\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql15;       Permissions: users-full
Source: "modules\PostgreSQL-16\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-16\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql16;       Permissions: users-full
Source: "modules\PostgreSQL-17\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-17\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql17;       Permissions: users-full
Source: "modules\PostgreSQL-18\ospanel_data\default\*";           DestDir: "{app}\config\PostgreSQL-18\default";  Flags: {#STD_FLAGS};  Components: modules\psql\postgresql18;       Permissions: users-full

Source: "modules\MongoDB-4.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.0\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb40;       Permissions: users-full
Source: "modules\MongoDB-4.2\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.2\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb42;       Permissions: users-full
Source: "modules\MongoDB-4.4\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-4.4\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb44;       Permissions: users-full
Source: "modules\MongoDB-5.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-5.0\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb50;       Permissions: users-full
Source: "modules\MongoDB-6.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-6.0\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb60;       Permissions: users-full
Source: "modules\MongoDB-7.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-7.0\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb70;       Permissions: users-full
Source: "modules\MongoDB-8.0\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-8.0\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb80;       Permissions: users-full
Source: "modules\MongoDB-8.2\ospanel_data\default\*";             DestDir: "{app}\config\MongoDB-8.2\default";    Flags: {#STD_FLAGS};  Components: modules\mongodb\mongodb82;       Permissions: users-full

Source: "modules\Bind\ospanel_data\default\*";                    DestDir: "{app}\config\Bind\default";           Flags: {#STD_FLAGS};  Components: modules\dns\bind;                Permissions: users-full
Source: "modules\Blackfire\ospanel_data\default\*";               DestDir: "{app}\config\Blackfire\default";      Flags: {#STD_FLAGS};  Components: modules\blackfire;               Permissions: users-full
Source: "modules\Mailpit\ospanel_data\default\*";                 DestDir: "{app}\config\Mailpit\default";        Flags: {#STD_FLAGS};  Components: modules\mail\mailpit;            Permissions: users-full
Source: "modules\Memcached\ospanel_data\default\*";               DestDir: "{app}\config\Memcached\default";      Flags: {#STD_FLAGS};  Components: modules\memcached;               Permissions: users-full
Source: "modules\Apache\ospanel_data\default\*";                  DestDir: "{app}\config\Apache\default";         Flags: {#STD_FLAGS};  Components: modules\web\apache;              Permissions: users-full
Source: "modules\Caddy\ospanel_data\default\*";                   DestDir: "{app}\config\Caddy\default";          Flags: {#STD_FLAGS};  Components: modules\web\caddy;               Permissions: users-full
Source: "modules\Nginx\ospanel_data\default\*";                   DestDir: "{app}\config\Nginx\default";          Flags: {#STD_FLAGS};  Components: modules\web\nginx;               Permissions: users-full
Source: "modules\PocketBase\ospanel_data\default\*";              DestDir: "{app}\config\PocketBase\default";     Flags: {#STD_FLAGS};  Components: modules\pocketbase;              Permissions: users-full
Source: "modules\RabbitMQ-3.13\ospanel_data\default\*";           DestDir: "{app}\config\RabbitMQ-3.13\default";  Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq313;    Permissions: users-full
Source: "modules\RabbitMQ-4.0\ospanel_data\default\*";            DestDir: "{app}\config\RabbitMQ-4.0\default";   Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq40;     Permissions: users-full
Source: "modules\RabbitMQ-4.1\ospanel_data\default\*";            DestDir: "{app}\config\RabbitMQ-4.1\default";   Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq41;     Permissions: users-full
Source: "modules\RabbitMQ-4.2\ospanel_data\default\*";            DestDir: "{app}\config\RabbitMQ-4.2\default";   Flags: {#STD_FLAGS};  Components: modules\rabbitmq\rabbitmq42;     Permissions: users-full
Source: "modules\Redis\ospanel_data\default\*";                   DestDir: "{app}\config\Redis\default";          Flags: {#STD_FLAGS};  Components: modules\redis;                   Permissions: users-full
Source: "modules\SFTPGo\ospanel_data\default\*";                  DestDir: "{app}\config\SFTPGo\default";         Flags: {#STD_FLAGS};  Components: modules\sftpgo;                  Permissions: users-full
Source: "modules\Smtp4dev\ospanel_data\default\*";                DestDir: "{app}\config\Smtp4dev\default";       Flags: {#STD_FLAGS};  Components: modules\mail\smtp4dev;           Permissions: users-full
Source: "modules\Unbound\ospanel_data\default\*";                 DestDir: "{app}\config\Unbound\default";        Flags: {#STD_FLAGS};  Components: modules\dns\unbound;             Permissions: users-full
Source: "modules\Vault\ospanel_data\default\*";                   DestDir: "{app}\config\Vault\default";          Flags: {#STD_FLAGS};  Components: modules\vault;                   Permissions: users-full

Source: "modules\PHP-7.2\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.2\default";          Flags: {#NUN_SFLAGS}; Components: modules\php\php72;               Permissions: users-full
Source: "modules\PHP-7.3\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.3\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php73;               Permissions: users-full
Source: "modules\PHP-7.4\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-7.4\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php74;               Permissions: users-full
Source: "modules\PHP-8.0\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.0\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php80;               Permissions: users-full
Source: "modules\PHP-8.1\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.1\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php81;               Permissions: users-full
Source: "modules\PHP-8.2\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.2\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php82;               Permissions: users-full
Source: "modules\PHP-8.3\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.3\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php83;               Permissions: users-full
Source: "modules\PHP-8.4\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.4\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php84;               Permissions: users-full
Source: "modules\PHP-8.5\ospanel_data\default_data\*";            DestDir: "{app}\data\PHP-8.5\default";          Flags: {#NUN_FLAGS};  Components: modules\php\php85;               Permissions: users-full

Source: "modules\Bind\ospanel_data\default_data\*";               DestDir: "{app}\data\Bind\default";             Flags: {#NUN_FLAGS};  Components: modules\dns\bind;                Permissions: users-full
Source: "modules\Unbound\ospanel_data\default_data\*";            DestDir: "{app}\data\Unbound\default";          Flags: {#NUN_FLAGS};  Components: modules\dns\unbound;             Permissions: users-full
Source: "modules\SFTPGo\ospanel_data\default_data\*";             DestDir: "{app}\data\SFTPGo\default";           Flags: {#NUN_FLAGS};  Components: modules\sftpgo;                  Permissions: users-full

Source: "modules\MySQL-5.7\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-5.7\default";        Flags: {#NUN_SFLAGS}; Components: modules\mysql\mysql57;           Permissions: users-full
Source: "modules\MySQL-8.0\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-8.0\default";        Flags: {#NUN_FLAGS};  Components: modules\mysql\mysql80;           Permissions: users-full
Source: "modules\MySQL-8.4\ospanel_data\default_data\*";          DestDir: "{app}\data\MySQL-8.4\default";        Flags: {#NUN_FLAGS};  Components: modules\mysql\mysql84;           Permissions: users-full

Source: "modules\MariaDB-10.4\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.4\default";     Flags: {#NUN_FLAGS};  Components: modules\mariadb\mariadb104;      Permissions: users-full
Source: "modules\MariaDB-10.5\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.5\default";     Flags: {#NUN_FLAGS};  Components: modules\mariadb\mariadb105;      Permissions: users-full
Source: "modules\MariaDB-10.6\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-10.6\default";     Flags: {#NUN_FLAGS};  Components: modules\mariadb\mariadb106;      Permissions: users-full
Source: "modules\MariaDB-10.11\ospanel_data\default_data\*";      DestDir: "{app}\data\MariaDB-10.11\default";    Flags: {#NUN_FLAGS};  Components: modules\mariadb\mariadb1011;     Permissions: users-full
Source: "modules\MariaDB-11.4\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.4\default";     Flags: {#NUN_FLAGS};  Components: modules\mariadb\mariadb114;      Permissions: users-full
Source: "modules\MariaDB-11.8\ospanel_data\default_data\*";       DestDir: "{app}\data\MariaDB-11.8\default";     Flags: {#NUN_FLAGS};  Components: modules\mariadb\mariadb118;      Permissions: users-full

Source: "modules\PostgreSQL-11\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-11\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql11;       Permissions: users-full
Source: "modules\PostgreSQL-12\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-12\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql12;       Permissions: users-full
Source: "modules\PostgreSQL-13\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-13\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql13;       Permissions: users-full
Source: "modules\PostgreSQL-14\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-14\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql14;       Permissions: users-full
Source: "modules\PostgreSQL-15\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-15\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql15;       Permissions: users-full
Source: "modules\PostgreSQL-16\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-16\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql16;       Permissions: users-full
Source: "modules\PostgreSQL-17\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-17\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql17;       Permissions: users-full
Source: "modules\PostgreSQL-18\ospanel_data\default_data\*";      DestDir: "{app}\data\PostgreSQL-18\default";    Flags: {#NUN_FLAGS};  Components: modules\psql\postgresql18;       Permissions: users-full

[Run]

Filename: "{app}\system\ssl\gen_root_cert.bat"; WorkingDir: "{app}\system\ssl"; StatusMsg: "{cm:GenCerts}";  Flags: runhidden waituntilterminated skipifdoesntexist; Components: core
Filename: "{app}\system\ssl\add_root_to_certstore.bat"; WorkingDir: "{app}\system\ssl"; StatusMsg: "{cm:ImportingCert}"; Flags: runhidden waituntilterminated skipifdoesntexist skipifsilent; Tasks: import_cert
Filename: "{app}\bin\ospanel_sys_prep_tool.exe"; Description: "{cm:RunSysPrep}"; Flags: postinstall nowait skipifdoesntexist skipifsilent; Components: core

[UninstallRun]

Filename: "{app}\system\ssl\del_root_from_certstore.bat"; WorkingDir: "{app}\system\ssl"; RunOnceId: "CleanupAfterUninstall"; Flags: runhidden waituntilterminated skipifdoesntexist

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
  APPInstallMode: Boolean;  // True=Normal (uninstallable), False=Portable
  
function IsSSE42Available: Boolean;
  external 'IsSSE42Available@files:CheckSSE42.dll stdcall delayload';

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

function NormalizePathForCompare(const S: string): string;
begin
  Result := Trim(S);
  Result := AnsiLowerCase(Result);

  // remove surrounding quotes
  if (Length(Result) >= 2) and (Result[1] = '"') and (Result[Length(Result)] = '"') then
    Result := Copy(Result, 2, Length(Result) - 2);

  // drop trailing backslash (except root like "c:\")
  if (Length(Result) > 3) and (Result[Length(Result)] = '\') then
    Result := Copy(Result, 1, Length(Result) - 1);
end;

procedure SplitSemicolonList(const S: string; var Arr: TArrayOfString);
var
  tmp, item: string;
  p, i: Integer;
begin
  tmp := S;
  SetArrayLength(Arr, 0);

  // normalize separators: ensure trailing ';' for parsing simplicity
  if (tmp <> '') and (tmp[Length(tmp)] <> ';') then
    tmp := tmp + ';';

  i := 0;
  while Pos(';', tmp) > 0 do
  begin
    p := Pos(';', tmp);
    item := Copy(tmp, 1, p - 1);
    tmp := Copy(tmp, p + 1, Length(tmp));

    item := Trim(item);
    if item <> '' then
    begin
      SetArrayLength(Arr, i + 1);
      Arr[i] := item;
      i := i + 1;
    end;
  end;
end;

function JoinSemicolonList(const Arr: TArrayOfString): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to GetArrayLength(Arr) - 1 do
  begin
    if Arr[i] = '' then
      continue;
    if Result = '' then
      Result := Arr[i]
    else
      Result := Result + ';' + Arr[i];
  end;
end;

function ContainsPath(const Arr: TArrayOfString; const PathToFind: string): Boolean;
var
  i: Integer;
  nFind: string;
begin
  Result := False;
  nFind := NormalizePathForCompare(PathToFind);

  for i := 0 to GetArrayLength(Arr) - 1 do
    if NormalizePathForCompare(Arr[i]) = nFind then
    begin
      Result := True;
      Exit;
    end;
end;

procedure RemovePath(var Arr: TArrayOfString; const PathToRemove: string);
var
  i, j: Integer;
  nRemove: string;
  NewArr: TArrayOfString;
begin
  nRemove := NormalizePathForCompare(PathToRemove);
  SetArrayLength(NewArr, 0);
  j := 0;

  for i := 0 to GetArrayLength(Arr) - 1 do
  begin
    if NormalizePathForCompare(Arr[i]) = nRemove then
      continue;

    SetArrayLength(NewArr, j + 1);
    NewArr[j] := Arr[i];
    j := j + 1;
  end;

  Arr := NewArr;
end;

procedure AddTo_Path();
var
  reg_root: Integer;
  reg_path: String;

  old_path: String;
  new_path: String;

  add_path: String;
  arr: TArrayOfString;

  hasValue: Boolean;
  changed: Boolean;
  i: Integer; 
begin
  reg_root := HKEY_CURRENT_USER;
  reg_path := 'Environment';
  add_path := ExpandConstant('{app}') + '\bin';

  // Read current PATH (may not exist)
  old_path := '';
  hasValue := RegQueryStringValue(reg_root, reg_path, 'Path', old_path);

  SplitSemicolonList(old_path, arr);

  changed := False;

  if IsUninstaller() then
  begin
    // remove our entry
    if ContainsPath(arr, add_path) then
    begin
      RemovePath(arr, add_path);
      changed := True;
    end;
  end
  else
  begin
    // add our entry to the front if missing
    if (add_path <> '') and (not ContainsPath(arr, add_path)) then
    begin
      // prepend
      SetArrayLength(arr, GetArrayLength(arr) + 1);
      // shift right
      if GetArrayLength(arr) > 1 then
        for i := GetArrayLength(arr) - 1 downto 1 do
          arr[i] := arr[i - 1];
      arr[0] := add_path;

      changed := True;
    end;
  end;

  // Build and write only if needed
  new_path := JoinSemicolonList(arr);

  // If value didn't exist and we didn't change anything, do nothing
  if (not hasValue) and (not changed) then
    Exit;

  // Avoid redundant write
  if hasValue and (NormalizePathForCompare(old_path) = NormalizePathForCompare(new_path)) then
    Exit;

  RegWriteStringValue(reg_root, reg_path, 'Path', new_path);
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

function GetInstallModeNormal: Boolean;
begin
  // Safe default: normal installation (uninstallable)
  Result := True;

  // If wizard page exists, use real user selection
  if Assigned(ModePage) then
    Result := ModePage.Values[0]
  else
    Result := APPInstallMode; // fallback if already set somewhere
end;

procedure InitializeWizard();
begin
  // default mode before any page exists (important for Uninstallable=IsUninstallable)
  APPInstallMode := True;

  WizardForm.BorderStyle := bsSizeable;
  WizardForm.BorderIcons := WizardForm.BorderIcons + [biMaximize];

  ModePage :=
    CreateInputOptionPage(
      wpLicense,
      ExpandConstant('{cm:InstallationMode}'),
      ExpandConstant('{cm:InstallationModeDescr}'),
      ExpandConstant('{cm:NormalInstallationDescr}') + #13#10#13#10 +
      ExpandConstant('{cm:PortableInstallationDescr}'),
      True,
      False
    );

  ModePage.Add(ExpandConstant('{cm:NormalInstallation}'));
  ModePage.Add(ExpandConstant('{cm:PortableInstallation}'));
  ModePage.Values[0] := True;

  // sync variable
  APPInstallMode := GetInstallModeNormal;

  WizardForm.TypesCombo.OnClick := @TypeComboOnChange;
end;

function IsUninstallable: Boolean;
begin
  APPInstallMode := GetInstallModeNormal;
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
    APPInstallMode := GetInstallModeNormal;
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
        APPInstallMode := GetInstallModeNormal;
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

function InitializeSetup(): Boolean;
begin
  if not IsSSE42Available() then begin
    MsgBox(ExpandConstant('{cm:sseError}'), mbError, MB_OK);
    Result := False;
  end else
    Result := True;
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