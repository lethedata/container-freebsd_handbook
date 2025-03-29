doc_date_cmd := "curl -sI https://download.freebsd.org/doc/en/books/handbook/handbook_en.tar.gz | awk -F': ' '{if ($1 == \"Last-Modified\") print $2}' | date -f - +%Y%m%d"
container_name := "freebsd-handbook"

run:
    # Build if image doesn't exist
    @podman image exists freebsd-handbook:latest || just --justfile {{justfile()}} build
    # Run Container
    podman run -d --name {{container_name}} --rm -p 127.0.0.1:3000:3000 {{container_name}}
    @echo Hosted: http://127.0.0.1:3000

kill:
    podman kill {{container_name}}

build:
    #!/usr/bin/env sh
    doc_date=`{{doc_date_cmd}}`
    @podman image exists {{container_name}}:$doc_date && echo "Image already exist" && exit 1 || true
    podman build -t {{container_name}}:$doc_date -t {{container_name}}:latest .

delete_image:
    #!/usr/bin/env sh
    doc_date=`{{doc_date_cmd}}`
    podman image exists {{container_name}}:$doc_date
    podman image rm {{container_name}}:$doc_date {{container_name}}:latest