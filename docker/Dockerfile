FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

#Entrypoint
COPY docker/entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

#Run
ENTRYPOINT ["/bin/entrypoint.sh"]