#!/bin/sh
# Chowns directories for docker-omero-athena
echo "Chowning directories for docker-omero-athena"
[[ -d /postgres ]] && \
    chown -R 70:70 /postgres || \
    (echo "NO POSTGRESQL DIRECTORIES PROVIDED" && MISSING=true)
[[ -d /server ]] && \
    chown -R 1000:997 /server || \
    (echo "NO OMERO-SERVER DIRECTORIES PROVIDED" && MISSING=true)
[[ -d /web ]] && \
    chown -R 999:998 /web || \
    (echo "NO OMERO-WEB DIRECTORIES PROVIDED" && MISSING=true)
[[ -d /nginx ]] && \
    chown -R 101:101 /nginx || \
    (echo "NO NGINX DIRECTORIES PROVIDED" && MISSING=true)
# if no flags raised, success
[[ -z $MISSING ]] && echo "SUCCESS!" && exit 0
# else failure
echo "SOMETHING WENT WRONG" && exit 1