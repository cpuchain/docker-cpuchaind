# Debugging

## Things to Check

* RAM utilization -- cpuchaind is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The cpuchain blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing cpuchaind Logs

    docker logs cpuchaind-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the cpuchaind node, but will not connect to already running containers or processes.

    docker run -v cpuchaind-data:/cpuchain --rm -it cpuchain/cpuchaind bash -l

You can also attach bash into running container to debug running cpuchaind

    docker exec -it cpuchaind-node bash -l


