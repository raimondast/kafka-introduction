#!/bin/bash

echo 'INIT REPLICA SET'
mongo --host mongodb:27017 <<EOF
   var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "mongodb:27017",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "mongo2:27017",
                "priority": 0
            },
            {
                "_id": 2,
                "host": "mongo3:27017",
                "priority": 0
            }
        ]
    };

    rs.initiate(cfg, { force: true });
    rs.reconfig(cfg, { force: true });
    db.getMongo().setReadPref('nearest');
EOF

while [ "$RESULT" != "true" ]; do
   RESULT=$(mongo mongodb:27017 --quiet --eval '﻿db.isMaster().ismaster');
   sleep 5;
done

mongo --host mongodb:27017 <<EOF
    use admin
    db.createUser(
        {
            user: "oplog",
            pwd: "1234",
            roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
        }
    )
EOF

echo 'IMPORT DATA'
mongoimport --host mongodb:27017 --db got --collection actors --type json --file /got/got.actors.json --jsonArray
mongoimport --host mongodb:27017 --db got --collection characters --type json --file /got/got.characters.json --jsonArray