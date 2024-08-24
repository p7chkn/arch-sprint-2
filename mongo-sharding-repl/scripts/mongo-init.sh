#!/bin/bash

###
# Инициализируем бд
###


### Инициализируем сервис конфигураций
docker compose exec -T mongo_config_srv mongosh --port 27016 --quiet <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "mongo_config_srv:27016" }
    ]
  }
);
exit();
EOF

### Инициализируем все ноды первого шарда
docker compose exec -T mongo_shard_1_1 mongosh --port 27011 --quiet <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "mongo_shard_1_1:27011" },
        { _id : 1, host : "mongo_shard_1_2:27012" },
        { _id : 2, host : "mongo_shard_1_3:27013" },
      ]
    }
);
exit();
EOF

### Инициализируем все ноды второго шарда
docker compose exec -T mongo_shard_2_1 mongosh --port 27021 --quiet <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "mongo_shard_2_1:27021" },
        { _id : 1, host : "mongo_shard_2_2:27022" },
        { _id : 2, host : "mongo_shard_2_3:27023" },
      ]
    }
);
exit();
EOF
