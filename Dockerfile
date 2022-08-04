FROM sibedge/postgres-plv8:13.7-3.0.0-bullseye

LABEL maintainer="takao.funami@gmail.com"

ENV POSTGIS_MAJOR 3
ENV POSTGIS_VERSION 3.2.2+dfsg-1.pgdg110+1

RUN apt-get update \
    && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
    && apt-get install -y --no-install-recommends \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./initdb-plv8.sh /docker-entrypoint-initdb.d/20_plv8.sh
COPY ./update-postgis.sh /usr/local/bin