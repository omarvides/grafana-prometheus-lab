# Simple grafana + prometheus lab repository

A simple repository lab to test (This readme is WIP)

## Requirements to run this test

- Docker
- Docker compose

### Optional

- NodeJS (Only if you want to run the backend locally)
- Golang (Oonly if you want to install bombardier via `go get`)

## To load test the backend application

I used bombardier to load test the backend app

- Github repo https://github.com/codesenberg/bombardier
- Releases https://github.com/codesenberg/bombardier/releases

### Usage example

> Before you start consider that this lab requires the following ports available
>
> - 9090
> - 3000
> - 4000

1. Start the lab environment by running

```
docker-compose up --build
```

> After running docker compose you can check that all the containers are running with `docker ps`, you can also visit http://localhost:4000/metrics, http://localhost:3000/ and http://localhost:9090/metrics to verify that everything is running correctly, grafana default admin and password are: user: `admin`, password: `admin`

2. Create a new board and load the configuration under the section `Board JSON` of this readme, once the board is created you can start sending traffic to the backend application, some examples below

```bash
bombardier -c 200 -n 10000 http://localhost:4000/status
```

```bash
bombardier -c 200 -n 10000 http://localhost:4000/hello
```

## Versions

### NodeJS

Install this only if you want to run the backend outside the container, everything in this lab runs within docker, you don't need to have anything else than docker installed

(Prefer [nvm](https://github.com/nvm-sh/nvm))

```
v10.19.0
```

### Docker

```
Client: Docker Engine - Community
 Version:           19.03.8
 API version:       1.40
 Go version:        go1.12.17
 Git commit:        afacb8b
 Built:             Wed Mar 11 01:21:11 2020
 OS/Arch:           darwin/amd64
 Experimental:      false
```

### Docker compose

```
docker-compose version 1.25.4, build 8d51620a
```

## Golang version

If you want to intall bombardier using go get

```
go version go1.13.5 darwin/amd64
```

## Board JSON

<details>
  <summary>Click to show board JSON</summary>
  
  ```json
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "gnetId": null,
  "graphTooltip": 0,
  "id": 1,
  "links": [],
  "panels": [
    {
      "aliasColors": {},
      "bars": true,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 10,
        "w": 13,
        "x": 0,
        "y": 0
      },
      "hiddenSeries": false,
      "id": 2,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": false,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "dataLinks": []
      },
      "percentage": false,
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": true,
      "steppedLine": false,
      "targets": [
        {
          "expr": "sum(rate(http_request_duration_seconds_bucket[1m])) by (path, status_code)",
          "interval": "",
          "legendFormat": "{{path}} - {{status_code}}",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Backend requests per second",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "transparent": true,
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": null,
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 10,
        "w": 11,
        "x": 13,
        "y": 0
      },
      "hiddenSeries": false,
      "id": 4,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "dataLinks": []
      },
      "percentage": false,
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          "interval": "",
          "legendFormat": "p95",
          "refId": "A"
        },
        {
          "expr": "histogram_quantile(0.50, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          "interval": "",
          "legendFormat": "p50",
          "refId": "B"
        },
        {
          "expr": "histogram_quantile(0.99, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          "interval": "",
          "legendFormat": "p99",
          "refId": "C"
        },
        {
          "expr": "histogram_quantile(0.999, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))",
          "interval": "",
          "legendFormat": "p999",
          "refId": "D"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Backend Percentiles",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "transparent": true,
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "s",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    }
  ],
  "refresh": "10s",
  "schemaVersion": 22,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-15m",
    "to": "now"
  },
  "timepicker": {
    "refresh_intervals": [
      "5s",
      "10s",
      "30s",
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "1d"
    ]
  },
  "timezone": "",
  "title": "Backend",
  "uid": "OXtaQo3Wz",
  "variables": {
    "list": []
  },
  "version": 8
}
```
</details>

## TODO

- Add the grafana boards as code
- Make ports for everything configurable
- Explain how to configure grafana
- Explain how to create the boards
