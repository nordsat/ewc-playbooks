# SAR processing

Installs the pytroll-watcher and trollflow2 quadlets processing Sentinel-1 SAR data.

## Secrets

The containers need two podman secrets. Create them as the user the playbook runs
as (the quadlets are rootless, so the secrets must live in that user's store):

- `sar_netrc`: a netrc file for the `catalogue.dataspace.copernicus.eu` host, eg:
  ```
  machine catalogue.dataspace.copernicus.eu login <user> password <password>
  ```
  then
  ```shell
  podman secret create sar_netrc ~/.netrc
  ```
- `sar_aws`: an aws config file with a `copernicus` profile holding the S3 keys, eg:
  ```ini
  [profile copernicus]
  endpoint_url = https://eodata.dataspace.copernicus.eu
  aws_access_key_id = ...
  aws_secret_access_key = ...
  ```
  then
  ```shell
  podman secret create sar_aws ~/.aws/config
  ```

Check with `podman secret ls`. To change a secret, `podman secret rm` it, create it
again, and restart the services (`systemctl --user restart pytroll-watcher-sar trollflow2-sar`).
The source files can be deleted once the secrets exist.

## Run with

```shell
ansible-playbook sar-processing.yaml -i <inventory> -l <host> -K
```

`-K` asks for the sudo password, needed to enable lingering, install packages and
write the quadlet files under `/etc/containers/systemd/users/`. Leave it out if the
user has passwordless sudo.

A service is restarted when its image, its unit file or the configuration changed.
