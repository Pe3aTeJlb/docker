#!/bin/bash

docker network create --subnet 192.168.20.0/29 bpmn

docker pull postgres:16.3-alpine3.20
docker run -d --rm --name postgres --hostname postgres --net bpmn --ip 192.168.20.2 -e POSTGRES_PASSWORD=demo postgres:16.3-alpine3.20

docker pull camunda/camunda-bpm-platform:7.21.0
docker run -d --rm --name camunda --hostname camunda --net bpmn --ip 192.168.20.3 --link postgres:db -e DB_DRIVER=org.postgresql.Driver -e DB_URL=jdbc:postgresql://db:5432/postgres -e DB_USERNAME=postgres -e DB_PASSWORD=demo -e WAIT_FOR=db:5432 camunda/camunda-bpm-platform:7.21.0
