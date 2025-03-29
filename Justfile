doc_date := `curl -sI https://download.freebsd.org/doc/en/books/handbook/handbook_en.tar.gz | awk -F': ' '{if ($1 == "Last-Modified") print $2}' | date -f - +%Y%m%d`

run:
    # Build if image doesn't exist
    @podman image exists freebsd-handbook:latest || just --justfile {{justfile()}} build
    # Run Container
    podman run -d --name freebsd-handbook --rm -p 127.0.0.1:3000:3000 freebsd-handbook
    @echo Hosted: http://127.0.0.1:3000

stop:
    podman kill freebsd-handbook

build:
    @podman image exists freebsd-handbook:{{doc_date}} && echo "Image already exist" && exit 1 || true
    podman build -t freebsd-handbook:{{doc_date}} -t freebsd-handbook:latest .

delete_image:
    podman image exists freebsd-handbook:{{doc_date}}
    podman image rm freebsd-handbook:{{doc_date}} freebsd-handbook:latest