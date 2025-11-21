# ewc-playbooks

Playbooks to install and configure Pytroll-based satellite data processing pipelines and optionally a WMS server. These playbooks are used in the European Weather Cloud (EWC) environment.

## Overview

`ewc-playbooks` provides **Ansible playbooks** to set up a robust, containerized environment for processing satellite data using the **Pytroll** ecosystem. Supported datasets include:

- **FCI** – Flexible Combined Imager (MTG-I)  
- **SEVIRI** – Spinning Enhanced Visible and Infrared Imager (MSG)  
- **VIIRS** – Visible Infrared Imaging Radiometer Suite (NOAA/NASA)

Optionally, a **WMS server** can be deployed to serve processed imagery for visualization in GIS clients.

**Key features:**

- Automated provisioning of multiple containers.
- Scalable and isolated pipelines for each satellite sensor.
- Integration with [Pytroll tools](https://pytroll.github.io/) for reading, processing, and resampling satellite data.
- Optional WMS server for serving processed data.

---


## Repository Structure
```
ewc-playbooks/
├── fci-processing/
├── fci-wms/
├── seviri-processing/
├── seviri-wms/
├── viirs-processing/
├── viirs-wms/
├── defaults.yml
├── satellite-data-processing-main.yaml
├── README.md
└── LICENSE
```
where:

- **`*-processing/`**: Container builds and Ansible tasks for satellite processing.  
- **`*-wms/`**: Container configuration for WMS services.  
- **`defaults.yml`**: Default variables.  
- **`satellite-data-processing-main.yaml`**: Main playbook orchestrating all deployments.

## Tested Platforms

This playbook and container setup have been tested on the following platforms:

| Operating System | Version       |
|-----------------|---------------|
| Ubuntu          | 22.04 LTS     |
| Ubuntu          | 24.04 LTS     |
| Rocky Linux     | 9             |

> Note: Other Linux distributions may work but have not been officially tested.

## Run the Playbook

1. Install Ansible

You can install Ansible and other Python dependencies in a virtual environment:

```bash
python3 -m venv venv
source venv/bin/activate
pip install ansible
```

For more details, see the Ansible installation guide: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

2. Define Your Inventory

Create the inventory file to list your hosts and groups. Example:

```txt
[satellite_hosts]
localhost ansible_connection=local
```

3. Run the main playbook (or any specific playbook) using:

```bash
ansible-playbook -i inventory satellite-data-processing-main.yaml
```

This will:
- Build and launch containers for processing FCI, SEVIRI, and VIIRS data.
- Optionally deploy WMS containers to serve processed outputs.

### Optional Variables

You can customize the playbook behavior using the following variables:

| Variable                | Default Value | Description                                           |
|-------------------------|---------------|-------------------------------------------------------|
| `satellite_data_type`   | `fci`         | Specify the satellite type to process (`fci`, `seviri`, `viirs`) |

### Passing Variables to Ansible

You can override these defaults when running the playbook by using the `--extra-vars` (`-e`) flag:

```bash
ansible-playbook -i inventory path/to/playbook/filename.yaml -e "satellite_data_type=seviri"
```

## Operation
Checkout the guidelines on how to work with data processing pipelines after successful playbook execution:
* [How to configure the Pytroll satellite data processing pipeline](./docs/how-to/how-to-configure-the-satellite-data-processing-pipeline.md)
