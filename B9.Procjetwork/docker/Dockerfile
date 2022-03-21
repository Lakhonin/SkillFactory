FROM python:3.9-alpine
RUN apk update --no-cache \
    && apk add postgresql-dev libpq --no-cache --virtual mypacks \
    && pip3 install --no-cache-dir psycopg2-binary flask configparser && mkdir -p /srv/app/conf \
    && apk del mypacks
COPY web.conf  /srv/app/conf/
COPY web.py /srv/app/web.py
CMD python /srv/app/web.py
EXPOSE 80
