#!/usr/bin/env bash

nohup gunicorn --pid=gunicorn.pid hello.wsgi:application -c gunicorn_conf.py --env DJANGO_DB=mysql &

sleep 30

perf c2c record  -a -u --ldlat 50 -- sleep 30
perf c2c report -NN -g --call-graph --full-symbols -c pid,iaddr --stdio >perf_report.txt

