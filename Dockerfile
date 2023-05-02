FROM osgeo/gdal:ubuntu-full-latest as builder

RUN apt-get update && apt-get install -y \
    cmake \
    make \
    libfreetype6-dev \
    libcairo2-dev \
    libfcgi-dev \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libproj-dev \
    libharfbuzz-dev \
    libfribidi-dev

RUN git clone https://github.com/MapServer/MapServer.git /tmp/mapserver
WORKDIR /tmp/mapserver
RUN mkdir build && cd build && cmake .. && make && make install

FROM osgeo/gdal:ubuntu-full-latest

COPY --from=builder /usr/local/ /usr/local/

EXPOSE 80
VOLUME ["/data"]

CMD ["mapserv", "-v"]