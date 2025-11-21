# How to configure the Pytroll Satellite Data Processing Pipeline

This page provided an introduction to configuring the container-based Pytroll processing pipeline within the EWC environment.

## Containers
> 💡 Each container runs as part of the Pytroll Processing VM and communicates through shared volumes.

The Pytroll processing workflow relies on three main containers:
* `trollstalker`: Monitors incoming files from local or remote sources and generates notifications.
* `segment-gatherer`: Aggregates file segments or messages from [trollstalker](https://github.com/pytroll/pytroll-collectors/blob/main/pytroll_collectors/trollstalker.py) into a single message containing all metadata required for image generation.
* `trollflow2`: Generates final imagery using the [satpy](https://github.com/pytroll/satpy) library.

## Volumes

The containers use several **mounted volumes** to share data, configurations, and logs.  

| Host Path                          | Target Path    | Description                                                               |
| ------------------------------- | -------------- | --------------------------------------------------------------------- |
| `{{ install_dir }}/fci-config/` | `/mnt/config/` | Configuration files for the processing pipeline. |
| `{{ input_dir }}`               | `/mnt/input/`  | Directory containing incoming satellite data. |
| `{{ output_dir }}`              | `/mnt/output/` |Directory where processed image products are written. |
| `{{ install_dir }}/logs/`       | `/mnt/logs/`   | Location where logs from each processing component are stored. |


### Configuration Files in `/mnt/config/`
> 💡 For additional examples (e.g. for FCI or SEVIRI), see the [ewc-config GitHub repository](https://github.com/nordsat/ewc-config).


The `/mnt/config/` directory contains several configuration files that define the processing workflow:

- `trollstalker.ini`: Main configuration for Trollstalker, defining how incoming files are detected and processed.  
- `trollstalker_logging.ini`: Logging configuration for Trollstalker.  
- `segment_gatherer.yaml`: Defines how segment messages are aggregated for downstream processing.  
- `supervisord.conf`: Supervisord configuration file, controlling which processing components start and how they are monitored.  
- `trollflow2.yaml`: Specifies which products to generate, including composites, target areas, file formats, and filename patterns.

## Related Resources
- [Pytroll Processing on the European Weather Cloud](https://confluence.ecmwf.int/x/ly6xG)
- [Official Pytroll Documentation](https://pytroll.github.io/)
