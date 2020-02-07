
#!/bin/bash

docker-compose rm --all && \
docker-compose build --no-cache && \
docker-compose up --force-recreate