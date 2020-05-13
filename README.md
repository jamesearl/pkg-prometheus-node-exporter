# prometheus-node-exporter

This generates an apt package for prometheus' [node_exporter](https://github.com/prometheus/node_exporter). It does not configure it.

It is available to apt-install from [gemfury](https://fury.io):
```
$ echo "deb [trusted=yes] https://apt.fury.io/jamesearl/ /" | sudo tee -a /etc/apt/sources.list.d/fury.list
$ sudo apt update
$ sudo apt install prometheus-node-exporter
```


## Development

> Be sure to update the VERSION variable in the [./Makefile](Makefile) as you go.

### Prereqs
Install FPM

`$> gem install fpm` or `$> bundle install`

### Working
From repo root:

`$> make dev`

> This will clean, build, and locally install.

### Publish
From repo root:

`$> make publish-gemfury`

> You need to be logged into gemfury to do this.
