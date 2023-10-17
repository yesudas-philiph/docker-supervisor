FROM node:20-bullseye

RUN apt-get update && \
    mkdir /var/apps && \
    apt-get install -y nano && \
    mkdir testapp1 testapp2 && \
    npm install forever -g


WORKDIR /var/apps
COPY ./ .

RUN apt-get -y install supervisor   && \
    mkdir -p /var/log/supervisor    && \
    mkdir -p /etc/supervisor/conf.d && \
	chmod +x app1.sh                && \
	chmod +x app2.sh

ADD ./test.conf /etc/supervisor/conf.d/test.conf

EXPOSE 3011 3015

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/test.conf"]
