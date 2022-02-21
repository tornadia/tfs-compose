FROM mariadb:latest
MAINTAINER tenlilnet

ADD env/schema.sql /docker-entrypoint-initdb.d/ddl.sql
ADD env/seed.sql /docker-entrypoint-initdb.d/dml.sql

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3306

CMD ["mariadbd"]
