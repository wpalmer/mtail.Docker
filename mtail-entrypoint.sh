#!/bin/bash
logs=
while read -d $'\0' log; do
    [[ -d "$log" ]] && continue
    [[ -n "$logs" ]] && logs="$logs,"
    logs="$logs$log"
done < <( find /var/spool/mtail -print0 )

/usr/bin/mtail \
    --progs /etc/mtail \
    --logs="$logs" \
    -logtostderr \
    -port 9197 \
    "$@"
