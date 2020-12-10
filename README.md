# OMERO.server websockets with SSL (docker-compose)

[![Actions Status](https://github.com/ome/docker-example-omero-websockets/workflows/Build/badge.svg)](https://github.com/ome/docker-example-omero-websockets/actions)

This is an example of running OMERO.server with websockets, Nginx, and SSL.

You can connect to OMERO.server using the OMERO API in Python in the following ways:
- OMERO.server ssl (4064): `localhost`, `ssl://localhost`, `ssl://localhost:4064`
- OMERO.server wss (4066): `wss://localhost:4066`
- Nginx http websockets (8080, not recommended since it's unencrypted but included for demo purposes): `ws://localhost:8080/omero-wss`
- Nginx https websockets (8443): `wss://localhost:8443/omero-wss`


## Run

Generate self-signed certificates (only needs to be run the first time):

    docker-compose -f docker-compose.icessl.yml -f docker-compose.yml run icessl

Run OMERO:

    docker-compose up -d
    docker-compose logs -f


## Basic tests

    docker-compose -f docker-compose.test.yml -f docker-compose.yml build
    docker-compose -f docker-compose.test.yml -f docker-compose.yml run test


## SELinux

If SELinux is enabled you may need to change the context on host directories, for example by creating a `.env` file containing:

    VOLOPTS=,z
