#!/bin/sh
#
# Purpose:
# Version: 1.0

MONGO_RUN_USER='mongodb'
MONGO_RUN_GROUP='mongodb'
MONGO_DB_DIR='/data/db'

#
# Create folder
#
mkdir -p ${MONGO_DB_DIR}
chown -R ${MONGO_RUN_USER}:${MONGO_RUN_GROUP} ${MONGO_DB_DIR}

#
# Start MongoDB daemon
#
su ${MONGO_RUN_USER} -s /bin/sh -c "mongod --dbpath ${MONGO_DB_DIR}"