#!/bin/sh
#
# Purpose:
# Version: 1.0

MONGO_RUN_USER='mongodb'
MONGO_RUN_GROUP='mongodb'
MONGO_DB_USER='root'
MONGO_DB_PASSWORD='root'
MONGO_DATA_DIR='/data'
MONGO_DB_DIR="${MONGO_DATA_DIR}/db"
MONGO_LOG_DIR="${MONGO_DATA_DIR}/log"
MONGO_LOG_PATH="${MONGO_LOG_DIR}/mongod.log"

CMD="mongod -v --dbpath ${MONGO_DB_DIR} --logpath ${MONGO_LOG_PATH} --logRotate reopen --logappend"

#
# Create folder
#
if [ ! -d ${MONGO_DATA_DIR} ]; then
    mkdir -p ${MONGO_DB_DIR}
    mkdir -p ${MONGO_LOG_DIR}
    touch ${MONGO_LOG_PATH}
    chown -R ${MONGO_RUN_USER}:${MONGO_RUN_GROUP} ${MONGO_DB_DIR}
    chown -R ${MONGO_RUN_USER}:${MONGO_RUN_GROUP} ${MONGO_LOG_DIR}
fi


#
# Start MongoDB daemon
#
su ${MONGO_RUN_USER} -s /bin/sh -c "${CMD} &"
sleep 5

#
# Set up admin user and restart MongoDB
#
mongo admin --eval "db.createUser({user: '${MONGO_DB_USER}', pwd: '${MONGO_DB_PASSWORD}', roles:[{role:'root', db:'admin'}]});"
su ${MONGO_RUN_USER} -s /bin/sh -c "mongod --shutdown" && su ${MONGO_RUN_USER} -s /bin/sh -c "${CMD} --auth"
