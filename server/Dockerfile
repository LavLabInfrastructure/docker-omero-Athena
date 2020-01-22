FROM openmicroscopy/omero-server:5.6
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN cd /opt/omero/server/ && \
    /opt/omero/server/venv3/bin/omego download -q --release 5.6 server --sym auto

USER root

# OMERO.py plugins
RUN /opt/omero/server/venv3/bin/python -m pip install \
    omero-cli-render \
    omero-metadata

USER omero-server

EXPOSE 4063 4064
VOLUME ["/OMERO", "/opt/omero/server/OMERO.server/var"]
