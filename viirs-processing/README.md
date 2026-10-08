# VIIRS processing

Installs the segment-gatherer and trollflow2 quadlets processing VIIRS data.

The files are not copied to this host: the `pytroll-watcher-viirs` on the EUMETCast
host (see `eumetcast/viirs-watcher.yaml`) announces them on `message_source`, and
trollflow2 reads them over ssh. The user running the playbook therefore needs an ssh
key, in `~/.ssh`, accepted by the EUMETCast host, which also has to be in
`~/.ssh/known_hosts`.

## Run with

```shell
ansible-playbook viirs-processing.yaml -i <inventory> -l <host> -K
```

`-K` asks for the sudo password, needed to enable lingering, install packages, create
the output directory and write the quadlet files under `/etc/containers/systemd/users/`.
Leave it out if the user has passwordless sudo.

A service is restarted when its image, its unit file or the configuration changed.

## Cleaning

The output directory is cleaned by `clean-viirs.sh`, installed by `viirs-wms`.
