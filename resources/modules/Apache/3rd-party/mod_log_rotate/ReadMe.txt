07 January 2016

                                                    Apache Lounge Distribution

                                       mod_log_rotate 1.0.2 for Apache 2.4 Win64 VS18
# Author : hexten
# Binary by: Steffen
# Mail: info@apachelounge.com
# Home: http://www.apachelounge.com/


Build with Visual Studio® 2026 (VS18)

# Install:

- Copy mod_log_rotate.so to your modules folder 


# Add to your httpd.conf

LoadModule log_rotate_module modules/mod_log_rotate.so


# Directives provided by mod_log_rotate 

You can specify a strftime() format string as the log file name. 
So you can do something like

CustomLog logs/access_log.%Y%m%d-%H%M%S common

and have log files named with a human readable date and time.


RotateLogs On|Off 
Enable / disable automatic log rotation. 
Once enabled mod_log_rotate takes responsibility for all log output server wide even if RotateLogs Off is subsequently used. 
That means that the BufferedLogs directive that is implemented by mod_log_config will be ignored. 
As BufferedLogs isn’t document and is flagged as an experimental feature this shouldn’t be a problem in production environments. 

RotateLogsLocalTime On|Off 
Normally the log rotation interval is based on UTC. 
For example an interval of 86400 (one day) will cause the logs to rotate at UTC 00:00. 
When this option is on, log rotation is timed relative to the local time. 


RotateInterval <interval> [<offset>] 

Set the interval in seconds for log rotation. 
The default is 86400 (one day). The shortest interval that can be specified is 60 seconds. 
An optional second argument specifies an offset in minutes which is applied to UTC (or local time if RotateLogsLocalTime is on). 
For example RotateInterval 86400 60 will cause logs to be rotated at 23:00 UTC. 


Enjoy,

Steffen
