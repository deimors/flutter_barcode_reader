# Build and Run on Windows
#  docker build -t flutter_barcode_protoc:latest ./
#  docker run -it -v %cd%\protos:/work/protos -v %cd%\lib:/work/lib flutter_barcode_protoc:latest

FROM google/dart:latest

ENV PATH="/root/.pub-cache/bin:${PATH}"
RUN apt-get update && \
    apt-get install -y protobuf-compiler && \
    apt-get install -y dos2unix && \
    pub global activate protoc_plugin && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

COPY generate_proto.sh /work/
WORKDIR /work
RUN dos2unix generate_proto.sh

ENTRYPOINT ./generate_proto.sh