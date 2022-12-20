# certfresh - Check SSL X.509 (PEM) certificate expiry and optionally refresh it.
## Install dependencies (Ubuntu)
> You need to have `Racket` and `GNU Make` on your system.

```bash
# add-apt-repository ppa:plt/racket && apt update && apt install -y racket make
```

## Build and (un)install
1. Build
    ```bash
    $ make
    ```

1. Install
    ```bash
    # make install
    ```

1. Uninstall
    ```bash
    # make uninstall
    ```

## Get help
1. Get help message
    ```bash
    $ certfresh -h
    ```

## Examples
> Keep in mind that you might have to run `certfresh` as `root` due to some files' permissions.

1. Check if a certificate expires in 15 days. Do nothing if it expires.
    ```bash
    $ certfresh -c ~/certs/fullchain.pem -d 15 -C
    ```

1. Check if a certificate expires in 45 days. Refresh using a script `/opt/refresh-cert.sh`.
    ```bash
    # certfresh -c ~/certs/fullchain.pem -d 45 -w '/opt/refresh.sh'
    ```