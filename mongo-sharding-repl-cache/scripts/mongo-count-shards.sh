# Считаем кол-во документов в первом шарде
docker compose exec -T mongo_shard_1 mongosh --port 27018 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF

# Считаем кол-во документов во втором шарде
docker compose exec -T mongo_shard_2 mongosh --port 27019 --quiet <<EOF
use somedb
db.helloDoc.countDocuments()
EOF