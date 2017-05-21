# Habitat nginx Load Balancer

This repository contains the [Habitat][habitat] plan source code for a dynamic
nginx load balancer which binds to a service backend using the habitat
supervisor.

## Basic Usage

Start the service with the Habitat supervisor

```
$ hab start sethvargo/nginx-lb --bind backend:my-service.group
```

or Docker

```
$ docker run -p 80:80 sethvargo/nginx-lb --bind backend:my-service.group
```

In these examples, the backend is bound to the service named "my-service" in the
group "group". If you do not specify a group when starting your service, it is
bound to default (i.e. "my-service.default").

The backend binding is required, and the service will not start if there is not
at least one upstream service to route to.

You may also need to specify the peer, especially if running under Docker:

```
$ docker run -p 80:80 sethvargo/nginx-lb \
    --peer 172.17.0.2 \
    --bind backend:my-service.group
```

## Configuration

Please see `default.toml` for all available configurations. The most common are:

- `server_name` - the FQDN to resolve requests for

- `http.port` - the port to bind/listen on

- `http.balancing` - the balancing algorithm to use for upstreams

## Requirements

In order to be "flexible", the load balancer requires:

- All backend services must expose a single `port` value. Other exposes are
  permitted, but nginx will bind to the exposed port on the service. Individual
  services can bind to different ports and ips - the load balancer will
  intelligently route.

- Port 80 must be accessible. By default, this binds to a privileged port, so
  root or root-like privileges are required. It is possible to configure the
  service to bind on a non-privileged port (like 8080), by specifying
  `http.port` in the configuration. For example:

    ```sh
    $ export HAB_NGINX_LB="$(cat <<-EOF
    [http]
    port = 8080
    EOF
    )"
    $ hab start sethvargo/nginx-lb --bind ...
    ```

## License

This Habitat plan is licensed under the MIT license. The nginx project and
source code is licensed under BSD.

[habitat]: https://habitat.sh
