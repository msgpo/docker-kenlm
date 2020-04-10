FROM ubuntu:eoan

ARG MAKE_THREADS=8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential libboost-all-dev cmake zlib1g-dev libbz2-dev liblzma-dev 

ADD download/eigen-3.2.8.tar.bz2 /
RUN cd /eigen-eigen-07105f7124f9 && \
    mkdir -p build && \
    cd build && \
    cmake .. && \
    make -j $MAKE_THREADS install

ADD download/kenlm-20200308.tar.gz /

# Build kenlm
RUN cd /kenlm && \
    mkdir -p build && \
    cd build && \
    cmake .. && \
    make -j $MAKE_THREADS

RUN cd /kenlm/build/bin && tar -czvf /kenlm.tar.gz *