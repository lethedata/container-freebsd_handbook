default:
  just --justfile {{justfile()}} --list

run-podman:
    podman run -d --name freebsd-handbook --rm -p 127.0.0.1:3000:3000 freebsd-handbook
    @echo Hosted: http://127.0.0.1:3000

build-podman:
    podman build -t freebsd-handbook:$(date '+%Y%m%d') -t freebsd-handbook:latest .

stop-podman:
    podman kill freebsd-handbook