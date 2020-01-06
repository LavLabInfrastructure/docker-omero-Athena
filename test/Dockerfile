FROM openmicroscopy/omero-server:5.6
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN cd /opt/omero/server/ && \
    /opt/omero/server/venv3/bin/omego download -q --release 5.5 server --sym auto

USER root

RUN pip install pytest

USER omero-server

ENTRYPOINT ["bash"]
