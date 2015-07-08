FROM kiyoto/fluentd:0.10.56-2.1.1

MAINTAINER tal@musk.al


# system update
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get clean -y

# tools
RUN apt-get install nginx supervisor -y

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

RUN mkdir -p /var/log/supervisor

ADD /server.conf /etc/nginx/sites-available/pixelserv
RUN ln -s /etc/nginx/sites-available/pixelserv /etc/nginx/sites-enabled/pixelserv
RUN rm /etc/nginx/sites-enabled/default

RUN mkdir /etc/fluent

ADD fluent.conf /etc/fluent/

RUN ["/usr/local/bin/gem", "install", "fluent-plugin-kinesis", "--no-rdoc", "--no-ri"]


# Clean up APT when done.
RUN apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define working directory.
WORKDIR /etc/nginx

# Define default command.

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports.
EXPOSE 80

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]