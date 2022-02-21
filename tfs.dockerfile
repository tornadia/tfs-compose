FROM ubuntu:20.04
MAINTAINER tenlilnet

ENV DEBIAN_FRONTEND=noninteractive

# build tools
RUN apt-get update
RUN apt-get install -y git cmake build-essential libluajit-5.1-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libboost-filesystem-dev libpugixml-dev libcrypto++-dev libfmt-dev libboost-date-time-dev

# devel tools
RUN apt-get install -y vim curl wget net-tools telnet

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


#Add a user
RUN useradd forgotten
RUN chown -R forgotten:forgotten /otserv

#Run Container as forgotten
USER forgotten

## running
CMD sleep 120 && ./tfs

#RUN cd /otserv/source && \
#    chmod +x autogen.sh && \
#    ./autogen.sh && \
#    ./configure --enable-mysql --enable-server-diag && \
#    make
