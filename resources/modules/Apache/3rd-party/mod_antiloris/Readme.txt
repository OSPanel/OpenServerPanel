 
  March 26, 2022
                                  Apache Haus Distribution 
                        
  Application:       Mod Antiloris 0.6.0 
  Distribution File: mod_antiloris-0.6.0-2.4.x-vs17-x64.zip 
 
  Original source by: Kees Monshouwer (http://www.monshouwer.eu/index.php?url=adres)
  Original Home:      ftp://ftp.monshouwer.eu/pub/linux/mod_antiloris/
  Original Version:   0.4.0

  Modification         Author                    Description
  ---------------------------------------------------------------------------------
  version 0.5.0     NewEraCracker: ......... Add other similar attack vectors 
                                             than just slowloris.
  version 0.5.1     Gregg (apachehaus.com):  Initial Apache 2.4.x compatability
  version 0.5.2     NewEraCracker: ......... Improved apache 2.4 compatibility and 
                                             remove a few non-attackable vectors
  version 0.6.0     NewEraCracker: ......... Add configuration for adjustable limits 
                                             based on the different vectors. Add option
                                             to ignore local IPs
  
  Win64 binary by: Gregg 
  Mail:            info@apachehaus.com 
  Home:            http://www.apachehaus.com 

  ** This build for Apache 2.4.x x64 only! **

  Supported Windows Versions:
  Windows 8/8.1/10 x64
  Windows Server 2012/2016/2019 x64

 NOTES:

  Modules built on Visual C++ 2022 do not run on Windows XP or Windows Server 2003

  The module is built with Visual Studio® 2022 x64, be sure to install the 
  new Visual C++ 2022 x64 Redistributable Package, download from;

https://aka.ms/vs/17/release/vc_redist.x64.exe
  
  INTRODUCTION 

	Mod_Antiloris is a module to mitigate the Slowloris attack against an Apache
  web server.

	INSTALL

  Copy mod_antiloris.so to your Apache 2.4.x modules folder
  .../apache24/modules/mod_antiloris.so

 
  # Add to your httpd.conf:

		LoadModule antiloris_module modules/mod_antiloris.so

  Configuration details for module mod_antiloris.c:
  
  Directive     Default   Description
  -------------------------------------------------------------------
  IPOtherLimit:   10      Maximum simultaneous idle connections 
                          per IP address.

  IPReadLimit:    10      Maximum simultaneous connections in READ
                          state per IP address.

  IPWriteLimit:   10      Maximum simultaneous connections in WRITE
                          state per IP address

  LocalIPs:      none    List of IPs (separated by spaces) whose
                         connection are always allowed

  EXAMPLE:

  LoadModule antiloris_module modules/mod_antiloris.so
  <IfModule antiloris_module>
      IPOtherLimit 10
      IPReadLimit  10
      IPWriteLimit 10
      LocalIPs     127.0.0.1 ::1
  </IfModule>
  
  # would allow 10 open connections in each state for a total of 30
  # and would not enforce limits from IPs 127.0.0.1 and ::1
