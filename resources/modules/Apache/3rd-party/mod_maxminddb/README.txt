# MaxMind DB Apache Module #

This module allows you to query MaxMind DB files from Apache 2.2+ using the
`libmaxminddb` library.

## Requirements ##

This module requires Apache 2.2 or 2.4 to be installed, including any
corresponding "dev" package, such as `apache2-dev` on Ubuntu. You should have
`apxs` or `apxs2` in your `$PATH`.

You also must install the [libmaxminddb](https://github.com/maxmind/libmaxminddb)
C library.

## Installation ##

To install the module from a tarball, run the following commands from the
directory with the extracted source:

    ./configure
    make install

To use another Apache installation, specify a path to the right apxs binary:

    ./configure --with-apxs=/foo/bar/apxs

If you are compiling the module from a Git checkout, you must have `automake`,
`autoconf`, and `libtool` installed and you must run `./bootstrap` before
running `configure`.

## Usage ##

To use this module, you must first download or create a MaxMind DB file. We
provide [free GeoLite2 databases](http://dev.maxmind.com/geoip/geoip2/geolite2)
as well as [commercial GeoIP2 databases](https://www.maxmind.com/en/geoip2-databases).

After installing this module and obtaining a database, you must now set up the
module in your Apache configuration file (e.g., `/etc/apache2/apache2.conf`)
or in an `.htaccess` file. You must set `MaxMindDBEnable` to enable the
module, `MaxMindDBFile` to specify the database to use, and `MaxMindDBEnv` to
bind the desired lookup result to an environment variable.

This module uses the client IP address for the lookup. This is not always what
you want. If you need to use an IP address specified in a header (e.g., by
your proxy frontend),
[mod_remoteip](http://httpd.apache.org/docs/current/mod/mod_remoteip.html) may
be used to set the client IP address.

## Directives ##

All directives may appear either in your server configuration or an
`.htaccess` file. Directives in `<Location>` and `<Directory>` blocks will
also apply to sub-locations and subdirectories. The configuration will be
merged with the most specific taking precedence. For instance, a conflicting
directive set for a subdirectory will be used for the subdirectory rather
than the directive set for the parent location.

### `MaxMindDBEnable` ###

This directive enables or disables the MaxMind DB lookup. Valid settings are
`On` and `Off`.

    MaxMindDBEnable On

### `MaxMindDBFile` ###

This directive associates a name placeholder with a MaxMind DB file on the
disk. You may specify multiple databases, each with its own name.

    MaxMindDBFile COUNTRY_DB /usr/local/share/GeoIP/GeoLite2-Country.mmdb
    MaxMindDBFile CITY_DB    /usr/local/share/GeoIP/GeoLite2-City.mmdb

The name placeholder can be any string that Apache parses as a word. We
recommend sticking to letters, numbers, and underscores.

### `MaxMindDBEnv` ###

This directive assigns the lookup result to an environment variable. The first
parameter after the directive is the environment variable. The second
parameter is the name of the database followed by the path to the desired data
using map keys or 0-based array indexes separated by `/`.

    MaxMindDBEnv MM_COUNTRY_CODE COUNTRY_DB/country/iso_code
    MaxMindDBEnv MM_REGION_CODE  CITY_DB/subdivisions/0/iso_code

## Exported Environment Variables ##

In addition to the environment variable specified by `MaxMindDBEnv`, this
module exports `MMDB_ADDR`, which contains the IP address used for lookups by
the module. This is primarily intended for debugging purposes.

## Examples ##

### City Database ###

    <IfModule mod_maxminddb.c>
        MaxMindDBEnable On
        MaxMindDBFile CITY_DB /usr/local/share/GeoIP/GeoLite2-City.mmdb

        MaxMindDBEnv MM_COUNTRY_CODE CITY_DB/country/iso_code
        MaxMindDBEnv MM_COUNTRY_NAME CITY_DB/country/names/en
        MaxMindDBEnv MM_CITY_NAME CITY_DB/city/names/en
        MaxMindDBEnv MM_LONGITUDE CITY_DB/location/longitude
        MaxMindDBEnv MM_LATITUDE CITY_DB/location/latitude
    </IfModule>

### Connection-Type Database ###

    <IfModule mod_maxminddb.c>
        MaxMindDBEnable On
        MaxMindDBFile CONNECTION_TYPE_DB /usr/local/share/GeoIP/GeoIP2-Connection-Type.mmdb

        MaxMindDBEnv MM_CONNECTION_TYPE CONNECTION_TYPE_DB/connection_type
    </IfModule>

### Domain Database ###

    <IfModule mod_maxminddb.c>
        MaxMindDBEnable On
        MaxMindDBFile DOMAIN_DB /usr/local/share/GeoIP/GeoIP2-Domain.mmdb

        MaxMindDBEnv MM_DOMAIN DOMAIN_DB/domain
    </IfModule>

### ISP Database ###

    <IfModule mod_maxminddb.c>
        MaxMindDBEnable On
        MaxMindDBFile ISP_DB /usr/local/share/GeoIP/GeoIP2-ISP.mmdb

        MaxMindDBEnv MM_ASN ISP_DB/autonomous_system_number
        MaxMindDBEnv MM_ASORG ISP_DB/autonomous_system_organization
        MaxMindDBEnv MM_ISP ISP_DB/isp
        MaxMindDBEnv MM_ORG ISP_DB/organization
    </IfModule>

### Blocking by Country ###

This example shows how to block users based on their country:

    MaxMindDBEnable On
    MaxMindDBFile DB /usr/local/share/GeoIP/GeoLite2-Country.mmdb
    MaxMindDBEnv MM_COUNTRY_CODE DB/country/iso_code

    SetEnvIf MM_COUNTRY_CODE ^(RU|DE|FR) BlockCountry
    Deny from env=BlockCountry

## Data Output Format ##

All data is provided as a string bound to the specified Apache environment
variable. Floating point numbers are provided to five digits after the decimal
place. All integers types except 128-bit integers are provided as decimal.
128-bit integers are returned as hexadecimal. Booleans are returned as "0" for
false and "1" for true.

Note that data stored as the "bytes" type in a MaxMind DB database can contain
null bytes and may end up truncated when stored in an environment variable. If
you really need to access this data, we recommend using [one of our
programming language
APIs](http://dev.maxmind.com/geoip/geoip2/downloadable/#MaxMind_APIs) instead.

## Support ##

Please report all issues with this code using the [GitHub issue tracker]
(https://github.com/maxmind/mod_maxminddb/issues).

If you are having an issue with a commercial MaxMind database that is not
specific to this module, please see [our support
page](http://www.maxmind.com/en/support).

## Versioning ##

The MaxMind DB Apache module uses [Semantic Versioning](http://semver.org/).

## Copyright and License ##

This software is Copyright (c) 2013-2014 by MaxMind, Inc.

This is free software, licensed under the Apache License, Version 2.0.
