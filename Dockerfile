FROM buildpack-deps:buster

# pg14-apt
RUN apt-get update;
RUN apt-get install -y --no-install-recommends gnupg2 wget
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list

# mysql8-apt
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 3A79BD29
RUN echo "deb http://repo.mysql.com/apt/debian/ buster mysql-8.0" | tee  /etc/apt/sources.list.d/mysql.list

# install packages 
RUN apt-get update
RUN apt-get install -y --no-install-recommends postgresql-client-14 mysql-client && \
    apt-get autoremove -y && rm -rf /var/lib/apt/lists/* && apt-get clean 

# Volumes - mapped 
VOLUME ["/tmp"]
VOLUME ["/data"]

# Copy App
COPY . /root/gobackup
WORKDIR /root/gobackup
RUN chmod a+x bin/install-gobackup.sh && bin/install-gobackup.sh

COPY bin/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

