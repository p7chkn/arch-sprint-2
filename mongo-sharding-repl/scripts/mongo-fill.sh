### Инициализируем роутер и наполняем базу данными
docker compose exec -T mongo_router mongosh --port 27020 --quiet <<EOF
sh.addShard("shard1/mongo_shard_1:27018");
sh.addShard("shard2/mongo_shard_2:27019");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )

use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
exit();
EOF
