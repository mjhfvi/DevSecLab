## Run a command inside the docker container

docker run --rm -i --cap-add=SYS_ADMIN grafana/k6:latest-with-browser run --vus 10 --duration 4s - <script.js

docker run --rm -i -v /mnt/c/repository/DevSecLab/k6-load-testing:/tmp/ --memory=128m --cpus="0.5" grafana/k6:latest-with-browser run --vus 10 --duration 4s /tmp/script.js


### Examples
https://grafana.com/docs/k6/latest/examples/
