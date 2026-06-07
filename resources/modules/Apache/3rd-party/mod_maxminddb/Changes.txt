## 1.2.0 - 2020-02-03

* Fix a bug where uninitialized memory could be accessed when looking up
  a path in a database. Pull Request by ylavic. GitHub #78.
* You may now set `MMDB_ADDR` to use that IP address rather than the
  remote address when doing the lookup. Pull request by Marc Stern. GitHub
  #63.
* Add new directive `MaxMindDBNetworkEnv` that allows setting an
  environment variable containing the network associated with an IP
  address.
* Add new directive `MaxMindDBSetNotes`. When set to `On`, Apache request
  notes will be set in addition to environment variables. Pull request by
  Marco Fontani. GitHub #76.

## 1.1.0 - 2016-10-19

* Fail loudly if any configured `MaxMindDBFile`s don't exist.
  Previously we would accept the configuration and silently do nothing.
* Support lookups in the root of VHost sections.
* `MaxMindDBEnv` now takes exactly two arguments. Previously, it allowed more
  arguments but ignored all but one set of arguments.

## 1.0.1 - 2015-03-16

* The module is now compiled with the `-std=c99 -fms-extensions` flags. This
  fixes compilation errors on older version of `gcc`.

## 1.0.0 - 2015-01-02

* First non-beta release.
* Updated documentation for completeness and correctness.
* Added maxminddb.h check to configure.ac.

## 0.2.0 - 2014-12-10

* The `MaxMindDBEnable` directive was changed from `OR_FILEINFO` to `OR_ALL`.
  The directive will now work anywhere and does not require
  `AllowOverride FileInfo` to work in an `.htaccess` file.

## 0.1.0 - 2014-11-17

* The module was largely rewritten. It now supports configuration contexts
  and handles configuration merging.

## 0.0.1 - 2014-02-12

* Initial release.
