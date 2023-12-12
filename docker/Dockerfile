FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

#Entrypoint
COPY docker/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

#Run
ENTRYPOINT ["/bin/entrypoint.sh"]