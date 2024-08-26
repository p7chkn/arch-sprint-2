### Инициализируем роутер и наполняем базу данными
docker compose exec -T mongo_router mongosh --port 27017 --quiet <<EOF
sh.addShard("shard1/mongo_shard_1_1:27011");
sh.addShard("shard1/mongo_shard_1_2:27012");
sh.addShard("shard1/mongo_shard_1_3:27013");
sh.addShard("shard2/mongo_shard_2_1:27021");
sh.addShard("shard2/mongo_shard_2_2:27022");
sh.addShard("shard2/mongo_shard_2_3:27023");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )

use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
exit();
EOF
