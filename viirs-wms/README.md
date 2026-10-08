# VIIRS WMS

Installs the postgis, db-push and sat-wms quadlets serving the VIIRS images produced by
`viirs-processing`.

## Secrets

The containers need the `pgpassword` podman secret, holding the postgres password.
Create it as the user the playbook runs as (the quadlets are rootless):

```shell
printf '%s' 'the-password' | podman secret create pgpassword -
```

Check with `podman secret ls`. Postgis only reads the password when it initialises
an empty `pg-data` directory, so changing the secret later also requires changing the
password in the database.

## Run with

```shell
ansible-playbook viirs-wms.yaml -i <inventory> -l <host> -K
```

Run it on the same host as `viirs-processing`, and after it: db-push subscribes to
`trollflow2-viirs` over the shared `pytroll_network`. `-K` asks for the sudo password,
see the `viirs-processing` README.

A service is restarted when its image, its unit file or the configuration changed.

## Cleaning

`clean-viirs.sh` is installed in the install directory and run from cron every 15
minutes. When `output_dir` grows over `clean_threshold_gb`, it deletes the oldest
products and their database rows. Try it with `clean-viirs.sh --dry-run`.
