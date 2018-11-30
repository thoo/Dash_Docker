#!/bin/bash
docker build -t dash_docker_hello .
docker run -d -p 8080:8080 dash_docker_hello
