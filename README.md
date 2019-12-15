# timescaledb-prometheus-grafana

Testing deployment of using [TimescaleDB](https://www.timescale.com/) as
remote storage for [Prometheus](https://prometheus.io/) and
[Grafana](https://grafana.com/) datasource.

Using [k3s](https://k3s.io/) for local Kubernetes cluster.

## Running locally

### Dependencies

- Docker: k3s is deployed through docker-compose. Everything else is on
  top of k3s.
- Kubectl: For interacting with k3s cluster.
- Make: *optional* Ease of running commands. Otherwise, contents can be
  copied and run directly.

### Commands

- `make`: Create local k3s cluster.
- `make check`: Get cluster info and status of nodes.
- `make apply`: Deploy prometheus, grafana, and timescaledb.
- `make destroy`: Teardown project.

### Instructions

1. Run `make`. Periodically run `make check` until cluster info is
   returned and both `master` and `node` are in a `Ready` state.
2. Run `make apply`. Once everything has successfully rolled out, a link
   will be printed for Grafana dashboard.
3. Login to Grafana.
   -  username: `admin`
   -  password: `secret`

TimescaleDB will already be configured as a datasource. Explore tab or a
new dashboard can be used to test timescaledb.
