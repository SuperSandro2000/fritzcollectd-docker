# Fritzcollecd Docker

An end-user Docker Image for [fritzcollectd](https://github.com/fetzerch/fritzcollectd)

## Configuration

Please refer to [this excelent guide](https://blog.butenostfreesen.de/2018/10/11/Fritz-Box-Monitoring-mit-Grafana-und-Raspberry/) to know how to configure Collectd, Influxdb and Grafana correctly.

### Special to this Image

* You need to have a fully configured and working Grafana and InfluxDB. To set those up please follow the above guide, their Docker Hub pages and the internet. It is out of scope to discuss this here.

* If your collectd is password protected (which it should be) you need to fill an auth_file in the following format and mount it into the container at ``/etc/collectd/auth_file``

```
collectd: YOUR_PASSWORD
```

* You also need to create a collectd.conf from the sample file shipped with this repo. At least you need to customize ``User``, ``Username`` and both ``Password``s. Follow the above guide to know how to create those accounts.

### Docker-Compose Snippet

```yaml
networks:
  grafana:

services:
  collectd:
    image: fritzcollectd
    build: .
    volumes:
      - $PWD/auth_file:/etc/collectd/auth_file:ro
      - $PWD/collectd.conf:/etc/collectd/collectd.conf:ro
    networks:
    - grafana
```
