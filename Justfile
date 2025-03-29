doc_date := `curl -sI https://download.freebsd.org/doc/en/books/handbook/handbook_en.tar.gz | awk -F': ' '{if ($1 == "Last-Modified") print $2}' | date -f - +%Y%m%d`

run:
    # Build if image doesn't exist
    @podman image exists freebsd-handbook:latest || just --justfile {{justfile()}} build
    # Run Container
    podman run -d --name freebsd-handbook --rm -p 127.0.0.1:3000:3000 freebsd-handbook
    @echo Hosted: http://127.0.0.1:3000

build:
    podman build -t freebsd-handbook:{{doc_date}} -t freebsd-handbook:latest .

stop:
    podman kill freebsd-handbook