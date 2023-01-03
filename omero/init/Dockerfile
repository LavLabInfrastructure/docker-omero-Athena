# Creates directories and chowns appropriate dirs
FROM docker.io/library/alpine:3.6
ADD change-permissions.sh /bin/change-permissions.sh
ENTRYPOINT "/bin/change-permissions.sh"