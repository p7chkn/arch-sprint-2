#!/bin/bash

###
# Инициализируем бд
###


### Инициализируем сервис конфигураций
docker compose exec -T mongo_config_srv mongosh --port 27017 --quiet <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "mongo_config_srv:27017" }
    ]
  }
);
exit();
EOF

### Инициализируем первый шард
docker compose exec -T mongo_shard_1 mongosh --port 27018 --quiet <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "mongo_shard_1:27018" },
       // { _id : 1, host : "mongo_shard_2:27019" }
      ]
    }
);
exit();
EOF

### Инициализируем второй шард
docker compose exec -T mongo_shard_2 mongosh --port 27019 --quiet <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
       // { _id : 0, host : "mongo_shard_1:27018" },
        { _id : 1, host : "mongo_shard_2:27019" }
      ]
    }
);
exit();
EOF
