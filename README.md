# FreeBSD Handbook Container

Small container hosting the **FreeBSD Handbook** and **Porter's Handbook** which is useful for offline viewing.

Uses [lipanski/docker-static-website](https://github.com/lipanski/docker-static-website) for a tiny (>100KB) [BusyBox httpd](https://www.busybox.net/) base image.

## Usage

Build and run with [Podman](https://podman.io/) using [just](https://github.com/casey/just) or manually with raw podman/docker commands.

### Podman Just

Run the image and build if needed:

```sh
just
```

### Podman Raw

Build the image:

```sh
podman build -t freebsd-handbook:$(date '+%Y%m%d') -t freebsd-handbook:latest .
```

Run the image:

```sh
podman run -d --name freebsd-handbook --rm -p 127.0.0.1:3000:3000 freebsd-handbook
```

### Docker

Build the image:

```sh
docker build -t freebsd-handbook:$(date '+%Y%m%d') -t freebsd-handbook:latest .
```

Run the image:

```sh
docker run -d --name freebsd-handbook --rm -p 127.0.0.1:3000:3000 freebsd-handbook
```