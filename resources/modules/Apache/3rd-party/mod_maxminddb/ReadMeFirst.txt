  
  March 27, 2022
                           Apache Haus Distribution
                        
  Application:       mod_maxminddb 1.2.0 for Apache 2.4.x VS17
  Distribution File: mod_maxmind-1.2.0.160-2.4.x-x64-vs17.zip
 
  Original Home: https://www.maxmind.com
  Win32 binary by: Gregg
  Mail: info@apachehaus.com
  Home: http://www.apachehaus.com


  Module Version: 1.2.0
  Maxmind API:    1.6.0


  Includes:

  Changes.txt
  CountryDB-LICENSE.txt
  GeoLite2-Country.mmdb   # GeoLite2 Country Database
  LICENSE.txt
  mod_maxminddb.so        # Apache module
  README.txt
  ReadMeFirst.txt         # This file


  ** This build for Apache 2.4.x x64 only! **

 
  # Notes:

  *** See https://forum.apachehaus.com/index.php?topic=1554.msg4221 for more configuring 
  information.

  Modules built on Visual C++ 2022 do not run on Windows XP or Windows Server 2003

  This module is built with Visual Studio® 2022 x64, be sure to install the 
  new Visual C++ 2022 x64 Redistributable Package, download from;

  https://aka.ms/vs/17/release/VC_redist.x64.exe


  # Install:

  Copy mod_maxminddb.so to your Apache 2.4.x modules folder
  .../Apache24/modules/mod_maxminddb.so

  Copy GeoLite2-Country.mmdb to your Apache 2.4.x conf/extra folder
  .../Apache24/conf/extra/GeoLite2-Country.mmdb

  Install the Visual C++ 2022 x64 Redistributable Package 
  Download, if you have not done so already, from the address above.

  # Add to your httpd.conf:

	LoadModule maxminddb_module modules/mod_maxminddb.so

	# Minimal Configuration below. For a more complete configuration,
	# see README.txt

    MaxMindDBEnable On
    MaxMindDBFile COUNTRY_DB conf/extra/GeoLite2-Country.mmdb

    MaxMindDBEnv MM_COUNTRY_CODE COUNTRY_DB/country/iso_code
    MaxMindDBEnv MM_COUNTRY_NAME COUNTRY_DB/country/names/en

  # Blocking by Country #

    SetEnvIf MM_COUNTRY_CODE ^(RU|US|UK) BlockCountry
    <RequireAll>
      Require all granted
      Require not env BlockCountry
    </RequireAll>
