# mtail, dockerized

This wraps [mtail](https://github.com/google/mtail) in a docker
container, so that you can start using it immediately.

By default, logs will be read from `/var/spool/mtail`, and progs from
`/etc/mtail`. The logs directory is scanned on launch, and no attempt is
made to detect additions or removals from that directory.

By default, mtail will listen on port 9197

Basic usage:

    docker run --rm wpalmer/mtail \
      -v /var/log/syslog:/var/spool/mtail \
      -v $HOME/mtail/myprogs:/etc/mtail
