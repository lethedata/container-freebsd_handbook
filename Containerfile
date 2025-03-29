FROM alpine:latest AS download_docs
ARG VERSION="0.13.0"
RUN for book in handbook porters-handbook; do \
    wget "https://download.freebsd.org/doc/en/books/${book}/${book}_en.tar.gz" && \
    tar -x -z -f "${book}_en.tar.gz"; \
    done
RUN ln -s public/en/books/handbook/index.html index.html

FROM lipanski/docker-static-website:latest
COPY --from=download_docs index.html .
COPY --from=download_docs /public .