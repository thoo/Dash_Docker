This is the repository for a skeleton for [Dash](https://dash.plot.ly/) application with a docker container.

To build the docker image, `cd` into the root directory and, run
```
docker build -t dash_docker_hello .
```

To run the dash application:
```
docker run -d -p 8080:8080 dash_docker_hello
```

To look for the running docker containers:
```
docker ps -a
```

To stop the docker container from running and releasing the port:
```
docker stop CONTAINER_ID(needed at least 3 digits);
```

To remove the container and image, run:
```
docker rm CONTAINER_ID; docker rmi IMAGE;
```
