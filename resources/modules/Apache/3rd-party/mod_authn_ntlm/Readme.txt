  May 27, 2020
                                  Apache Haus Distribution
                        
  Application:       mod_authn_ntml 1.0.8 stable for Apache 2.4.x x64
  Distribution File: mod_authn_ntml-1.0.8-2.4.x-x64-vs16.zip
 
  Author: TQsoft GmbH <info@tqsoft.de>
          Inspired by mod_auth_sspi project from Tim Castello
  Original Home: https://github.com/YvesR/mod_authn_ntlm

  Win64 binary by: Gregg
  Mail: info@apachehaus.com
  Home: http://www.apachehaus.com

  authn_ntml module for Apache 2.4 x64 only

  Supported Windows Versions:
  Windows 8/8.1/10 x64 only
  Windows Server 2008/2012/2016 x64 only

  INTRODUCTION

  mod_authn_ntml is an Apache 2.4 SSPI NTLM based authentication module for 
  Windows


  NOTES

  Modules built on Visual C++ 2019 do not run on Windows XP or Windows Server 2003

  The module is built with Visual Studio® 2019 x64, be sure to install the 
  new Visual C++ 2019 x64 Redistributable Package, download from;

  https://aka.ms/vs/16/release/VC_redist.x64.exe


  INSTALL

  Copy mod_authn_ntml.so to your Apache 2.4.x modules folder
  .../Apache24/modules/mod_authn_ntml.so 

  Install the Visual C++ 2019 x64 Redistributable Package 
  Download, if you have not done so already, from the address above.



  CONFIGURATION

  Load mod_ldap.so if not already loaded (required by mod_authn_ntml)

  Add to your httpd.conf:

  LoadModule auth_ntlm_module modules/mod_authn_ntlm.so


  <Location /authenticate >
    AuthName "Private location"
    AuthType SSPI
    NTLMAuth On
    NTLMAuthoritative On
    <RequireAll>
        <RequireAny>
            Require valid-user
            #require sspi-user EMEA\group_name
        </RequireAny>
        <RequireNone>
            Require user "ANONYMOUS LOGON"
            Require user "NT-AUTORITÄT\ANONYMOUS-ANMELDUNG"
        </RequireNone>
    </RequireAll>

    # use this to add the authenticated username to you header
    # so any backend system can fetch the current user
    # rewrite_module needs to be loaded then

     RewriteEngine On
     RewriteCond %{LA-U:REMOTE_USER} (.+)
     RewriteRule . - [E=RU:%1]
     RequestHeader set X_ISRW_PROXY_AUTH_USER %{RU}e

  </Location>


  DIRECTIVES REFERENCE

  NTLMAuth: set to 'on' to activate NTLM authentication here

  NTLMAuthoritative: set to 'off' to allow access control to be passed along to 
                     lower modules if the UserID is not known to this module

  NTLMBasicPreferred: set to 'on' if you want basic authentication to be the higher 
                      priority

  NTLMChainAuth: set to 'on' if you want an alternative authorization module like 
                 SVNPathAuthz to work at the same level

  NTLMDomain: set to the domain you want users authenticated against for cleartext 
              authentication - if not specified, the local machine, then all trusted 
              domains are checked

  NTLMMSIE3Hack: set to 'on' if you expect MSIE 3 clients to be using this server

  NTLMOfferBasic: set to 'on' to allow the client to authenticate against NT with 
                  'Basic' authentication instead of using the NTLM protocol

  NTLMOfferNTLM: set to 'off' to allow access control to be passed along to lower 
                 modules if the UserID is not known to this module

  NTLMOmitDomain: set to 'on' if you want the usernames to have the domain prefix 
                  OMITTED, on = user, off = DOMAIN\user

  NTLMPackage: set to the name of the package you want to use to authenticate users

  NTLMPackages: set to the name of the package you want to use to authenticate users

  NTLMPerRequestAuth: set to 'on' if you want authorization per request instead of 
                      per connection

  NTLMUsernameCase: set to 'lower' if you want the username and domain to be lowercase, 
                    set to 'upper' if you want the username and domain to be uppercase, 
                    if not specified, username and domain case conversion is disabled

