# certfresh - Check SSL X.509 (PEM) certificate expiry and optionally refresh it.
## Install dependencies (Ubuntu)
> You need to have `Racket` and `GNU Make` on your system.

```
# add-apt-repository ppa:plt/racket && apt update && apt install -y racket make
```

## Build and (un)install
1. Build
    ```
    $ make
    ```

1. Install
    ```
    # make install
    ```

1. Uninstall
    ```
    # make uninstall
    ```

## Get help
1. Get help message
    ```
    $ certfresh -h
    ```

## Examples
> Keep in mind that you might have to run `certfresh` as `root` due to some files' permissions.

1. Check if a certificate expires in 15 days. Do nothing if it expires.
    ```
    $ certfresh -c ~/certs/fullchain.pem -d 15 -C
    ```

1. Check if a certificate expires in 45 days. Refresh using a script `/opt/refresh-cert.sh`.
    ```
    # certfresh -c ~/certs/fullchain.pem -d 45 -w '/opt/refresh.sh'
    ```

1. Perform daily checks to see if the cert expires in 15 days. If it does, run the worker script and redirect `stdout` and `stderr` to a log file.
    > It depends on file permissions. If your certs are available for `root` only, then:

    1. Open `crontab`
        ```
        # crontab -e
        ```

    1. Add a line similar to the following one
        ```
        @daily /usr/local/bin/certfresh -c /etc/ssl-certs/fullchain.pem -d 15 -w '/opt/refresh-cert.sh' &>> /var/log/certfresh.log
        ```

