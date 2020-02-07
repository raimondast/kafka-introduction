
docker-compose -f ./cp-all-in-one/docker-compose.yml down
docker-compose -f ./ksql/docker-compose.yml down
docker-compose -f ./cdc/docker-compose.yml down
docker-compose -f ./app/docker-compose.yml down
docker-compose -f ./kafka-core/docker-compose.yml down


docker ps