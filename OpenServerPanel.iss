#define AppVersion      "6.0.0.450"
#define AppVersion_     "6_0_0_450"
#define AppDomain       "ospanel.io"
#define AppTitle        "Open Server Panel"
#define CurrentYear     GetDateTimeString('yyyy', '', '')

[Setup]

SourceDir               = .
OutputDir               = release
OutputBaseFilename      = ospanel_setup_{#AppVersion_}

// Application info

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

Compression             = lzma2/ultra64
InternalCompressLevel   = ultra64
LZMAUseSeparateProcess  = yes
SolidCompression        = yes
LZMABlockSize           = 262144
LZMADictionarySize      = 262144
LZMANumBlockThreads     = 4
LZMANumFastBytes        = 273

// Misc  

AllowNoIcons            = yes
AllowRootDirectory      = yes
AllowUNCPath            = no
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
Uninstallable           = no
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

Name: "desktop_icon";   Description:  "{cm:CreateDesktopIcon}";                      Components: core\panel; GroupDescription: "{cm:AdditionalIcons}"
Name: "autostarticon";  Description:  "{cm:AutoStartProgram,{#AppTitle}}";           Components: core\panel
Name: "add_to_path";    Description:  "{cm:AddToPath}";                              Components: core\panel
Name: "import_cert";    Description:  "{cm:ImportCert}";                             Components: core\panel

[Icons]

Name: "{group}\{#AppTitle}";               Filename: "{app}\bin\ospanel.exe";        WorkingDir: "{app}";    Components: core\panel; Flags: createonlyiffileexists
Name: "{group}\System Preparation Tool";   Filename: "{app}\bin\syspreptool.exe";    WorkingDir: "{app}";    Components: core\panel; Flags: createonlyiffileexists
Name: "{group}\{cm:RunManual}";            Filename: "https://github.com/OSPanel/OpenServerPanel/wiki";      Components: core\panel; Languages: en
Name: "{group}\{cm:RunManual}";            Filename: "https://github.com/OSPanel/OpenServerPanel/wiki/%D0%94%D0%BE%D0%BA%D1%83%D0%BC%D0%B5%D0%BD%D1%82%D0%B0%D1%86%D0%B8%D1%8F"; Components: core\panel; Languages: ru ua be
Name: "{group}\{cm:RunDonate}";            Filename: "https://ospanel.io/donate/";                           Components: core\panel
Name: "{autodesktop}\{#AppTitle}";         Filename: "{app}\bin\ospanel.exe";        WorkingDir: "{app}";    Flags: createonlyiffileexists; Tasks: desktop_icon
Name: "{userstartup}\{#AppTitle}";         Filename: "{app}\bin\ospanel.exe";        WorkingDir: "{app}";    Flags: createonlyiffileexists; Tasks: autostarticon

[Components]

Name: "core";                  Description: "{cm:GeneralData}";                                              Flags: disablenouninstallwarning
Name: "core\panel";            Description: "{cm:CoreData}";      Types: full compact;                       Flags: disablenouninstallwarning
Name: "core\browscap";         Description: "{cm:Browscap}";      Types: full;                               Flags: disablenouninstallwarning
Name: "core\geobases";         Description: "{cm:Geobases}";      Types: full;                               Flags: disablenouninstallwarning
 
Name: "dns";                   Description: "DNS";                                                           Flags: disablenouninstallwarning
Name: "dns\bind";              Description: "Bind";               Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;  
Name: "dns\unbound";           Description: "Unbound";            Types: full;                               Flags: disablenouninstallwarning

Name: "git";                   Description: "Git";                Types: full;                               Flags: disablenouninstallwarning

Name: "mdb";                   Description: "MariaDB";                                                       Flags: disablenouninstallwarning
Name: "mdb\mariadb101";        Description: "MariaDB 10.1";       Types: full;                               Flags: disablenouninstallwarning
Name: "mdb\mariadb102";        Description: "MariaDB 10.2";       Types: full;                               Flags: disablenouninstallwarning
Name: "mdb\mariadb103";        Description: "MariaDB 10.3";       Types: full;                               Flags: disablenouninstallwarning
Name: "mdb\mariadb104";        Description: "MariaDB 10.4";       Types: full;                               Flags: disablenouninstallwarning
Name: "mdb\mariadb105";        Description: "MariaDB 10.5";       Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mdb\mariadb106";        Description: "MariaDB 10.6";       Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mdb\mariadb107";        Description: "MariaDB 10.7";       Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mdb\mariadb108";        Description: "MariaDB 10.8";       Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mdb\mariadb109";        Description: "MariaDB 10.9";       Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mdb\mariadb1010";       Description: "MariaDB 10.10";      Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mdb\mariadb1011";       Description: "MariaDB 10.11";      Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mdb\mariadb110";        Description: "MariaDB 11.0";       Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;

Name: "mem";                   Description: "Memcached";                                                     Flags: disablenouninstallwarning
Name: "mem\memcached14";       Description: "Memcached 1.4";      Types: full;                               Flags: disablenouninstallwarning
Name: "mem\memcached16";       Description: "Memcached 1.6";      Types: full;                               Flags: disablenouninstallwarning

Name: "mongo";                 Description: "MongoDB";                                                       Flags: disablenouninstallwarning
Name: "mongo\mongodb30";       Description: "MongoDB 3.0";        Types: full;                               Flags: disablenouninstallwarning
Name: "mongo\mongodb32";       Description: "MongoDB 3.2";        Types: full;                               Flags: disablenouninstallwarning
Name: "mongo\mongodb34";       Description: "MongoDB 3.4";        Types: full;                               Flags: disablenouninstallwarning
Name: "mongo\mongodb36";       Description: "MongoDB 3.6";        Types: full;                               Flags: disablenouninstallwarning
Name: "mongo\mongodb40";       Description: "MongoDB 4.0";        Types: full;                               Flags: disablenouninstallwarning
Name: "mongo\mongodb42";       Description: "MongoDB 4.2";        Types: full;                               Flags: disablenouninstallwarning
Name: "mongo\mongodb44";       Description: "MongoDB 4.4";        Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mongo\mongodb50";       Description: "MongoDB 5.0";        Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "mongo\mongodb60";       Description: "MongoDB 6.0";        Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;

Name: "db";                    Description: "MySQL";                                                         Flags: disablenouninstallwarning
Name: "db\mysql55";            Description: "MySQL 5.5";          Types: full;                               Flags: disablenouninstallwarning
Name: "db\mysql56";            Description: "MySQL 5.6";          Types: full;                               Flags: disablenouninstallwarning
Name: "db\mysql57";            Description: "MySQL 5.7";          Types: full compact;                       Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "db\mysql80";            Description: "MySQL 8.0";          Types: full compact;                       Flags: disablenouninstallwarning; check: IsWindows10OrNewer;

Name: "php";                   Description: "PHP";                                                           Flags: disablenouninstallwarning
Name: "php\php71";             Description: "PHP 7.1";            Types: full;                               Flags: disablenouninstallwarning
Name: "php\php72";             Description: "PHP 7.2";            Types: full;                               Flags: disablenouninstallwarning
Name: "php\php73";             Description: "PHP 7.3";            Types: full;                               Flags: disablenouninstallwarning
Name: "php\php74";             Description: "PHP 7.4";            Types: full compact;                       Flags: disablenouninstallwarning
Name: "php\php80";             Description: "PHP 8.0";            Types: full compact;                       Flags: disablenouninstallwarning
Name: "php\php81";             Description: "PHP 8.1";            Types: full compact;                       Flags: disablenouninstallwarning
Name: "php\php82";             Description: "PHP 8.2";            Types: full compact;                       Flags: disablenouninstallwarning

Name: "psql";                  Description: "PostgreSQL";                                                    Flags: disablenouninstallwarning
Name: "psql\postgresql95";     Description: "PostgreSQL 9.5";     Types: full;                               Flags: disablenouninstallwarning
Name: "psql\postgresql96";     Description: "PostgreSQL 9.6";     Types: full;                               Flags: disablenouninstallwarning
Name: "psql\postgresql10";     Description: "PostgreSQL 10";      Types: full;                               Flags: disablenouninstallwarning
Name: "psql\postgresql11";     Description: "PostgreSQL 11";      Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "psql\postgresql12";     Description: "PostgreSQL 12";      Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "psql\postgresql13";     Description: "PostgreSQL 13";      Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "psql\postgresql14";     Description: "PostgreSQL 14";      Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;
Name: "psql\postgresql15";     Description: "PostgreSQL 15";      Types: full;                               Flags: disablenouninstallwarning; check: IsWindows10OrNewer;

Name: "redis";                 Description: "Redis";                                                         Flags: disablenouninstallwarning
Name: "redis\redis30";         Description: "Redis 3.0";          Types: full;                               Flags: disablenouninstallwarning
Name: "redis\redis32";         Description: "Redis 3.2";          Types: full;                               Flags: disablenouninstallwarning
Name: "redis\redis40";         Description: "Redis 4.0";          Types: full;                               Flags: disablenouninstallwarning
Name: "redis\redis50";         Description: "Redis 5.0";          Types: full;                               Flags: disablenouninstallwarning
Name: "redis\redis70";         Description: "Redis 7.0";          Types: full;                               Flags: disablenouninstallwarning 

[Files]

Source: "config\domains.ini";                                     DestDir: "{app}\config";                   Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                 Components: core\panel;                   Permissions: users-full
Source: "config\program.ini";                                     DestDir: "{app}\config";                   Flags: sortfilesbyextension sortfilesbyname ignoreversion confirmoverwrite;                                 Components: core\panel;                   Permissions: users-full
Source: "licenses\*";                                             DestDir: "{app}\licenses";                 Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "bin\*";                                                  DestDir: "{app}\bin";                      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "home\*";                                                 DestDir: "{app}\home";                     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "system\*";                                               DestDir: "{app}\system";                   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "user\blackfire\*";                                       DestDir: "{app}\user\blackfire";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "user\ssl\*";                                             DestDir: "{app}\user\ssl";                 Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "user\browscap\lite_php_browscap.ini";                    DestDir: "{app}\user\browscap";            Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "modules\ControlPanel\*";                                 DestDir: "{app}\modules\ControlPanel";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full
Source: "modules\Perl\*";                                         DestDir: "{app}\modules\Perl";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\panel;                   Permissions: users-full

Source: "user\browscap\*"; Excludes: "lite_php_browscap.ini";     DestDir: "{app}\user\browscap";            Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: core\browscap;     Permissions: users-full
Source: "user\geo\*";                                             DestDir: "{app}\user\geo";                 Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: core\geobases;                Permissions: users-full

Source: "modules\PHP-7.1\*";                                      DestDir: "{app}\modules\PHP-7.1";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: php\php71;         Permissions: users-full
Source: "modules\PHP-7.2\*";                                      DestDir: "{app}\modules\PHP-7.2";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php72;                    Permissions: users-full
Source: "modules\PHP-7.3\*";                                      DestDir: "{app}\modules\PHP-7.3";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php73;                    Permissions: users-full
Source: "modules\PHP-7.4\*";                                      DestDir: "{app}\modules\PHP-7.4";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php74;                    Permissions: users-full
Source: "modules\PHP-8.0\*";                                      DestDir: "{app}\modules\PHP-8.0";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php80;                    Permissions: users-full
Source: "modules\PHP-8.1\*";                                      DestDir: "{app}\modules\PHP-8.1";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php81;                    Permissions: users-full
Source: "modules\PHP-8.2\*";                                      DestDir: "{app}\modules\PHP-8.2";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php82;                    Permissions: users-full

Source: "modules\MySQL-5.5\*";                                    DestDir: "{app}\modules\MySQL-5.5";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: db\mysql55;        Permissions: users-full
Source: "modules\MySQL-5.6\*";                                    DestDir: "{app}\modules\MySQL-5.6";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: db\mysql56;                   Permissions: users-full
Source: "modules\MySQL-5.7\*";                                    DestDir: "{app}\modules\MySQL-5.7";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: db\mysql57;                   Permissions: users-full
Source: "modules\MySQL-8.0\*";                                    DestDir: "{app}\modules\MySQL-8.0";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: db\mysql80;                   Permissions: users-full

Source: "modules\MariaDB-10.1\*";                                 DestDir: "{app}\modules\MariaDB-10.1";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb101;               Permissions: users-full
Source: "modules\MariaDB-10.2\*";                                 DestDir: "{app}\modules\MariaDB-10.2";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb102;               Permissions: users-full
Source: "modules\MariaDB-10.3\*";                                 DestDir: "{app}\modules\MariaDB-10.3";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb103;               Permissions: users-full
Source: "modules\MariaDB-10.4\*";                                 DestDir: "{app}\modules\MariaDB-10.4";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb104;               Permissions: users-full
Source: "modules\MariaDB-10.5\*";                                 DestDir: "{app}\modules\MariaDB-10.5";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb105;               Permissions: users-full
Source: "modules\MariaDB-10.6\*";                                 DestDir: "{app}\modules\MariaDB-10.6";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb106;               Permissions: users-full
Source: "modules\MariaDB-10.7\*";                                 DestDir: "{app}\modules\MariaDB-10.7";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb107;               Permissions: users-full
Source: "modules\MariaDB-10.8\*";                                 DestDir: "{app}\modules\MariaDB-10.8";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb108;               Permissions: users-full
Source: "modules\MariaDB-10.9\*";                                 DestDir: "{app}\modules\MariaDB-10.9";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb109;               Permissions: users-full
Source: "modules\MariaDB-10.10\*";                                DestDir: "{app}\modules\MariaDB-10.10";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb1010;              Permissions: users-full
Source: "modules\MariaDB-10.11\*";                                DestDir: "{app}\modules\MariaDB-10.11";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb1011;              Permissions: users-full
Source: "modules\MariaDB-11.0\*";                                 DestDir: "{app}\modules\MariaDB-11.0";     Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb110;               Permissions: users-full

Source: "modules\PostgreSQL-9.5\*";                               DestDir: "{app}\modules\PostgreSQL-9.5";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: psql\postgresql95; Permissions: users-full
Source: "modules\PostgreSQL-9.6\*";                               DestDir: "{app}\modules\PostgreSQL-9.6";   Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql96;            Permissions: users-full
Source: "modules\PostgreSQL-10\*";                                DestDir: "{app}\modules\PostgreSQL-10";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql10;            Permissions: users-full
Source: "modules\PostgreSQL-11\*";                                DestDir: "{app}\modules\PostgreSQL-11";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql11;            Permissions: users-full
Source: "modules\PostgreSQL-12\*";                                DestDir: "{app}\modules\PostgreSQL-12";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql12;            Permissions: users-full
Source: "modules\PostgreSQL-13\*";                                DestDir: "{app}\modules\PostgreSQL-13";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql13;            Permissions: users-full
Source: "modules\PostgreSQL-14\*";                                DestDir: "{app}\modules\PostgreSQL-14";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql14;            Permissions: users-full
Source: "modules\PostgreSQL-15\*";                                DestDir: "{app}\modules\PostgreSQL-15";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql15;            Permissions: users-full

Source: "modules\MongoDB-3.0\*";                                  DestDir: "{app}\modules\MongoDB-3.0";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: mongo\mongodb30;   Permissions: users-full
Source: "modules\MongoDB-3.2\*";                                  DestDir: "{app}\modules\MongoDB-3.2";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb32;              Permissions: users-full
Source: "modules\MongoDB-3.4\*";                                  DestDir: "{app}\modules\MongoDB-3.4";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb34;              Permissions: users-full
Source: "modules\MongoDB-3.6\*";                                  DestDir: "{app}\modules\MongoDB-3.6";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb36;              Permissions: users-full
Source: "modules\MongoDB-4.0\*";                                  DestDir: "{app}\modules\MongoDB-4.0";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb40;              Permissions: users-full
Source: "modules\MongoDB-4.2\*";                                  DestDir: "{app}\modules\MongoDB-4.2";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb42;              Permissions: users-full
Source: "modules\MongoDB-4.4\*";                                  DestDir: "{app}\modules\MongoDB-4.4";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb44;              Permissions: users-full
Source: "modules\MongoDB-5.0\*";                                  DestDir: "{app}\modules\MongoDB-5.0";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb50;              Permissions: users-full
Source: "modules\MongoDB-6.0\*";                                  DestDir: "{app}\modules\MongoDB-6.0";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mongo\mongodb60;              Permissions: users-full

Source: "modules\Memcached-1.4\*";                                DestDir: "{app}\modules\Memcached-1.4";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: mem\memcached14;   Permissions: users-full
Source: "modules\Memcached-1.6\*";                                DestDir: "{app}\modules\Memcached-1.6";    Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mem\memcached16;              Permissions: users-full

Source: "modules\Redis-3.0\*";                                    DestDir: "{app}\modules\Redis-3.0";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: redis\redis30;                Permissions: users-full
Source: "modules\Redis-3.2\*";                                    DestDir: "{app}\modules\Redis-3.2";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: redis\redis32;                Permissions: users-full
Source: "modules\Redis-4.0\*";                                    DestDir: "{app}\modules\Redis-4.0";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: redis\redis40;                Permissions: users-full
Source: "modules\Redis-5.0\*";                                    DestDir: "{app}\modules\Redis-5.0";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: redis\redis50;                Permissions: users-full
Source: "modules\Redis-7.0\*";                                    DestDir: "{app}\modules\Redis-7.0";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: redis\redis70;                Permissions: users-full

Source: "modules\Bind\*";                                         DestDir: "{app}\modules\Bind";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: dns\bind;                     Permissions: users-full
Source: "modules\Git\*";                                          DestDir: "{app}\modules\Git";              Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: git;                          Permissions: users-full
Source: "modules\Unbound\*";                                      DestDir: "{app}\modules\Unbound";          Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: dns\unbound;                  Permissions: users-full

Source: "data\PHP-7.1\*";                                         DestDir: "{app}\data\PHP-7.1";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: php\php71;         Permissions: users-full
Source: "data\PHP-7.2\*";                                         DestDir: "{app}\data\PHP-7.2";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php72;                    Permissions: users-full
Source: "data\PHP-7.3\*";                                         DestDir: "{app}\data\PHP-7.3";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php73;                    Permissions: users-full
Source: "data\PHP-7.4\*";                                         DestDir: "{app}\data\PHP-7.4";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php74;                    Permissions: users-full
Source: "data\PHP-8.0\*";                                         DestDir: "{app}\data\PHP-8.0";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php80;                    Permissions: users-full
Source: "data\PHP-8.1\*";                                         DestDir: "{app}\data\PHP-8.1";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php81;                    Permissions: users-full
Source: "data\PHP-8.2\*";                                         DestDir: "{app}\data\PHP-8.2";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: php\php82;                    Permissions: users-full

Source: "data\Bind\*";                                            DestDir: "{app}\data\Bind";                Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: dns\bind;                     Permissions: users-full
Source: "data\Unbound\*";                                         DestDir: "{app}\data\Unbound";             Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: dns\unbound;                  Permissions: users-full

Source: "data\MySQL-5.5\*";                                       DestDir: "{app}\data\MySQL-5.5";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: db\mysql55;        Permissions: users-full
Source: "data\MySQL-5.6\*";                                       DestDir: "{app}\data\MySQL-5.6";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: db\mysql56;                   Permissions: users-full
Source: "data\MySQL-5.7\*";                                       DestDir: "{app}\data\MySQL-5.7";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: db\mysql57;                   Permissions: users-full
Source: "data\MySQL-8.0\*";                                       DestDir: "{app}\data\MySQL-8.0";           Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: db\mysql80;                   Permissions: users-full

Source: "data\MariaDB-10.1\*";                                    DestDir: "{app}\data\MariaDB-10.1";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb101;               Permissions: users-full
Source: "data\MariaDB-10.2\*";                                    DestDir: "{app}\data\MariaDB-10.2";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb102;               Permissions: users-full
Source: "data\MariaDB-10.3\*";                                    DestDir: "{app}\data\MariaDB-10.3";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb103;               Permissions: users-full
Source: "data\MariaDB-10.4\*";                                    DestDir: "{app}\data\MariaDB-10.4";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb104;               Permissions: users-full
Source: "data\MariaDB-10.5\*";                                    DestDir: "{app}\data\MariaDB-10.5";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb105;               Permissions: users-full
Source: "data\MariaDB-10.6\*";                                    DestDir: "{app}\data\MariaDB-10.6";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb106;               Permissions: users-full
Source: "data\MariaDB-10.7\*";                                    DestDir: "{app}\data\MariaDB-10.7";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb107;               Permissions: users-full
Source: "data\MariaDB-10.8\*";                                    DestDir: "{app}\data\MariaDB-10.8";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb108;               Permissions: users-full
Source: "data\MariaDB-10.9\*";                                    DestDir: "{app}\data\MariaDB-10.9";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb109;               Permissions: users-full
Source: "data\MariaDB-10.10\*";                                   DestDir: "{app}\data\MariaDB-10.10";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb1010;              Permissions: users-full
Source: "data\MariaDB-10.11\*";                                   DestDir: "{app}\data\MariaDB-10.11";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb1011;              Permissions: users-full
Source: "data\MariaDB-11.0\*";                                    DestDir: "{app}\data\MariaDB-11.0";        Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: mdb\mariadb110;               Permissions: users-full

Source: "data\PostgreSQL-9.5\*";                                  DestDir: "{app}\data\PostgreSQL-9.5";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite solidbreak; Components: psql\postgresql95; Permissions: users-full
Source: "data\PostgreSQL-9.6\*";                                  DestDir: "{app}\data\PostgreSQL-9.6";      Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql96;            Permissions: users-full
Source: "data\PostgreSQL-10\*";                                   DestDir: "{app}\data\PostgreSQL-10";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql10;            Permissions: users-full
Source: "data\PostgreSQL-11\*";                                   DestDir: "{app}\data\PostgreSQL-11";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql11;            Permissions: users-full
Source: "data\PostgreSQL-12\*";                                   DestDir: "{app}\data\PostgreSQL-12";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql12;            Permissions: users-full
Source: "data\PostgreSQL-13\*";                                   DestDir: "{app}\data\PostgreSQL-13";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql13;            Permissions: users-full
Source: "data\PostgreSQL-14\*";                                   DestDir: "{app}\data\PostgreSQL-14";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql14;            Permissions: users-full
Source: "data\PostgreSQL-15\*";                                   DestDir: "{app}\data\PostgreSQL-15";       Flags: sortfilesbyextension sortfilesbyname ignoreversion recursesubdirs createallsubdirs confirmoverwrite; Components: psql\postgresql15;            Permissions: users-full

Source: "{app}\modules\Bind\ospanel_data\original\*";             DestDir: "{app}\config\Bind";              Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: dns\bind;           Permissions: users-full
Source: "{app}\modules\ControlPanel\ospanel_data\original\*";     DestDir: "{app}\config\ControlPanel";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core\panel;         Permissions: users-full
Source: "{app}\modules\Git\ospanel_data\original\*";              DestDir: "{app}\config\Git";               Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: git;                Permissions: users-full
Source: "{app}\modules\Perl\ospanel_data\original\*";             DestDir: "{app}\config\Perl";              Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: core\panel;         Permissions: users-full

Source: "{app}\modules\PHP-7.1\ospanel_data\original\*";          DestDir: "{app}\config\PHP-7.1";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php71;          Permissions: users-full
Source: "{app}\modules\PHP-7.2\ospanel_data\original\*";          DestDir: "{app}\config\PHP-7.2";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php72;          Permissions: users-full
Source: "{app}\modules\PHP-7.3\ospanel_data\original\*";          DestDir: "{app}\config\PHP-7.3";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php73;          Permissions: users-full
Source: "{app}\modules\PHP-7.4\ospanel_data\original\*";          DestDir: "{app}\config\PHP-7.4";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php74;          Permissions: users-full
Source: "{app}\modules\PHP-8.0\ospanel_data\original\*";          DestDir: "{app}\config\PHP-8.0";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php80;          Permissions: users-full
Source: "{app}\modules\PHP-8.1\ospanel_data\original\*";          DestDir: "{app}\config\PHP-8.1";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php81;          Permissions: users-full
Source: "{app}\modules\PHP-8.2\ospanel_data\original\*";          DestDir: "{app}\config\PHP-8.2";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: php\php82;          Permissions: users-full

Source: "{app}\modules\MySQL-5.5\ospanel_data\original\*";        DestDir: "{app}\config\MySQL-5.5";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: db\mysql55;         Permissions: users-full
Source: "{app}\modules\MySQL-5.6\ospanel_data\original\*";        DestDir: "{app}\config\MySQL-5.6";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: db\mysql56;         Permissions: users-full
Source: "{app}\modules\MySQL-5.7\ospanel_data\original\*";        DestDir: "{app}\config\MySQL-5.7";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: db\mysql57;         Permissions: users-full
Source: "{app}\modules\MySQL-8.0\ospanel_data\original\*";        DestDir: "{app}\config\MySQL-8.0";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: db\mysql80;         Permissions: users-full

Source: "{app}\modules\MariaDB-10.1\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.1";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb101;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.2\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.2";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb102;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.3\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.3";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb103;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.4\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.4";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb104;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.5\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.5";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb105;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.6\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.6";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb106;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.7\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.7";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb107;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.8\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.8";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb108;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.9\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-10.9";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb109;     Permissions: users-full
Source: "{app}\modules\MariaDB-10.10\ospanel_data\original\*";    DestDir: "{app}\config\MariaDB-10.10";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb1010;    Permissions: users-full
Source: "{app}\modules\MariaDB-10.11\ospanel_data\original\*";    DestDir: "{app}\config\MariaDB-10.11";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb1011;    Permissions: users-full
Source: "{app}\modules\MariaDB-11.0\ospanel_data\original\*";     DestDir: "{app}\config\MariaDB-11.0";      Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mdb\mariadb110;     Permissions: users-full

Source: "{app}\modules\Memcached-1.4\ospanel_data\original\*";    DestDir: "{app}\config\Memcached-1.4";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mem\memcached14;    Permissions: users-full
Source: "{app}\modules\Memcached-1.6\ospanel_data\original\*";    DestDir: "{app}\config\Memcached-1.6";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mem\memcached16;    Permissions: users-full
Source: "{app}\modules\MongoDB-3.0\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-3.0";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb30;    Permissions: users-full
Source: "{app}\modules\MongoDB-3.2\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-3.2";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb32;    Permissions: users-full
Source: "{app}\modules\MongoDB-3.4\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-3.4";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb34;    Permissions: users-full
Source: "{app}\modules\MongoDB-3.6\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-3.6";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb36;    Permissions: users-full
Source: "{app}\modules\MongoDB-4.0\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-4.0";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb40;    Permissions: users-full
Source: "{app}\modules\MongoDB-4.2\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-4.2";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb42;    Permissions: users-full
Source: "{app}\modules\MongoDB-4.4\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-4.4";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb44;    Permissions: users-full
Source: "{app}\modules\MongoDB-5.0\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-5.0";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb50;    Permissions: users-full
Source: "{app}\modules\MongoDB-6.0\ospanel_data\original\*";      DestDir: "{app}\config\MongoDB-6.0";       Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: mongo\mongodb60;    Permissions: users-full

Source: "{app}\modules\PostgreSQL-9.5\ospanel_data\original\*";   DestDir: "{app}\config\PostgreSQL-9.5";    Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql95;  Permissions: users-full
Source: "{app}\modules\PostgreSQL-9.6\ospanel_data\original\*";   DestDir: "{app}\config\PostgreSQL-9.6";    Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql96;  Permissions: users-full
Source: "{app}\modules\PostgreSQL-10\ospanel_data\original\*";    DestDir: "{app}\config\PostgreSQL-10";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql10;  Permissions: users-full
Source: "{app}\modules\PostgreSQL-11\ospanel_data\original\*";    DestDir: "{app}\config\PostgreSQL-11";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql11;  Permissions: users-full
Source: "{app}\modules\PostgreSQL-12\ospanel_data\original\*";    DestDir: "{app}\config\PostgreSQL-12";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql12;  Permissions: users-full
Source: "{app}\modules\PostgreSQL-13\ospanel_data\original\*";    DestDir: "{app}\config\PostgreSQL-13";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql13;  Permissions: users-full
Source: "{app}\modules\PostgreSQL-14\ospanel_data\original\*";    DestDir: "{app}\config\PostgreSQL-14";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql14;  Permissions: users-full
Source: "{app}\modules\PostgreSQL-15\ospanel_data\original\*";    DestDir: "{app}\config\PostgreSQL-15";     Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: psql\postgresql15;  Permissions: users-full

Source: "{app}\modules\Redis-3.0\ospanel_data\original\*";        DestDir: "{app}\config\Redis-3.0";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis30;      Permissions: users-full
Source: "{app}\modules\Redis-3.2\ospanel_data\original\*";        DestDir: "{app}\config\Redis-3.2";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis32;      Permissions: users-full
Source: "{app}\modules\Redis-4.0\ospanel_data\original\*";        DestDir: "{app}\config\Redis-4.0";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis40;      Permissions: users-full
Source: "{app}\modules\Redis-5.0\ospanel_data\original\*";        DestDir: "{app}\config\Redis-5.0";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis50;      Permissions: users-full
Source: "{app}\modules\Redis-7.0\ospanel_data\original\*";        DestDir: "{app}\config\Redis-7.0";         Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: redis\redis70;      Permissions: users-full

Source: "{app}\modules\Unbound\ospanel_data\original\*";          DestDir: "{app}\config\Unbound";           Flags: external ignoreversion recursesubdirs createallsubdirs confirmoverwrite;  Components: dns\unbound;        Permissions: users-full

[Run]

Filename: "{app}\system\ssl\gen_root_cert.bat"; WorkingDir: "{app}\system\ssl"; StatusMsg: "{cm:GenCerts}";  Flags: runhidden waituntilterminated skipifdoesntexist; Components: core\panel
Filename: "{app}\system\ssl\add_root_to_certstore.bat"; WorkingDir: "{app}\system\ssl"; StatusMsg: "{cm:ImportingCert}"; Flags: runhidden waituntilterminated skipifdoesntexist skipifsilent; Tasks: import_cert
Filename: "{app}\bin\syspreptool.exe"; Description: "{cm:RunSysPrep}"; Flags: postinstall nowait skipifdoesntexist skipifsilent; Components: core\panel

[Code]

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

		if add_path = path_arr[i-1] then begin
  		if IsUninstaller() = true then begin
				continue;
  		end else begin
				update_path := false;
	    end;
		end;

		if i = 1 then begin
			final_path := path_arr[i-1];
		end else begin
			final_path := final_path + ';' + path_arr[i-1];
		end;
	end;

	if (IsUninstaller() = false) AND (update_path = true) then
		final_path := add_path + ';' + final_path;

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
  VolumeInfo         : String;
  VolumeSerialNumber : DWORD;
  PartitionType      : String;
begin
  SetLength(Result, MAX_LEN);
  if GetVolumeInformation( PAnsiChar( String( s )[ 1 ] + ':\' ), '', 0, VolumeSerialNumber, NotUsed, VolumeFlags, Result, Length(Result)) then 
    begin
      SetLength(Result, Pos(#0, Result) - 1);
      Result := trim(AnsiLowerCase( Result ));
    end else Result := '';
end; 

procedure InitializeWizard();
begin
  WizardForm.WelcomeLabel1.Font.Style := [];
end; 

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpFinished then
  begin
    WizardForm.FinishedHeadingLabel.Font.Style := [];
  end;
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
