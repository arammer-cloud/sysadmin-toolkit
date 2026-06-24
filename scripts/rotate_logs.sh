#!/bin/bash

find /home/adm_ramos/sysadmin-toolkit/logs/ -name "health-*.log" -mtime +7 -delete
