FROM openmicroscopy/omero-server:5.6
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN cd /opt/omero/server/ && \
    /opt/omero/omego/bin/omego download -q --release 5.5 server --sym auto

USER root

# OMERO.py plugins
RUN pip install \
    omero-cli-render \
    omero-metadata

USER omero-server

EXPOSE 4063 4064
VOLUME ["/OMERO", "/opt/omero/server/OMERO.server/var"]
