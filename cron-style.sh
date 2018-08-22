#!/bin/bash

# m h dom mon dow

sched="41 18 * * 3"

read m_when h_when dom_when mon_when dow_when <<< $sched

echo "$m_when"

echo "$mon_when"

delay=0
gone=0
while true; do
        m_now=$(date +%M)
        h_now=$(date +%H)
        dom_now=$(date +%d)
        mon_now=$(date +%m)
        dow_now=$(date +%u)
        go=0
        if [ "$m_when" = "*" -o "$m_when" = "$m_now" ]; then
                go=$[$go+1]
        fi
        if [ "$h_when" = "*" -o "$h_when" = "$h_now" ]; then
                go=$[$go+1]
        fi
        if [ "$dom_when" = "*" -o "$dom_when" = "$dom_now" ]; then
                go=$[$go+1]
        fi
        if [ "$mon_when" = "*" -o "$mon_when" = "$mon_now" ]; then
                go=$[$go+1]
        fi
        if [ "$dow_when" = "*" -o "$dow_when" = "$dow_now" ]; then
                go=$[$go+1]
        fi
        if [ $go -eq 5 ]; then
                if [ $delay -eq 0 ]; then
                        replay=$[$(date +%s)+61]
                        echo "e' ora di andare"
                        delay=1
                fi
                if [ $(date +%s) -gt $replay ]; then
                        delay=0
                fi
        else
                echo "niente da fare: quando: $m_when $h_when $dom_when $mon_when $dow_when . adesso: $m_now $h_now $dom_now $mon_now $dow_now"
        fi
        sleep 5
done
