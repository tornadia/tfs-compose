FROM ubuntu:20.04
MAINTAINER tenlilnet

ENV DEBIAN_FRONTEND=noninteractive

# build tools
RUN apt-get update
RUN apt-get install -y git cmake build-essential libluajit-5.1-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libboost-filesystem-dev libpugixml-dev libcrypto++-dev libfmt-dev libboost-date-time-dev

# devel tools
RUN apt-get install -y vim curl wget net-tools telnet netcat iputils-ping

# workspace
COPY files/src /otserv/src
COPY files/cmake /otserv/cmake
COPY files/CMakeLists.txt /otserv
WORKDIR /otserv

## building
RUN mkdir build && cd build && cmake .. && make && \
    mv tfs ..

COPY files/config.lua.dist /otserv
COPY files/key.pem /otserv
COPY files/data /otserv/data
COPY env/config.lua /otserv

COPY scripts/tfs_entrypoint.sh /otserv
RUN chmod +x /otserv/tfs_entrypoint.sh

#Add a user
RUN useradd forgotten
RUN chown -R forgotten:forgotten /otserv

#Run Container as forgotten
USER forgotten

## running
CMD timeout $TFS_WAIT_TIME bash tfs_entrypoint.sh && ./tfs

#RUN cd /otserv/source && \
#    chmod +x autogen.sh && \
#    ./autogen.sh && \
#    ./configure --enable-mysql --enable-server-diag && \
#    make
