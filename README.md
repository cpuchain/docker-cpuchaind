CPUchaind for Docker
===================

[![Docker Stars](https://img.shields.io/docker/stars/cpuchain/cpuchaind.svg)](https://hub.docker.com/r/cpuchain/cpuchaind/)
[![Docker Pulls](https://img.shields.io/docker/pulls/cpuchain/cpuchaind.svg)](https://hub.docker.com/r/cpuchain/cpuchaind/)
[![Build Status](https://travis-ci.org/cpuchain/docker-cpuchaind.svg?branch=master)](https://travis-ci.org/cpuchain/docker-cpuchaind/)
[![ImageLayers](https://images.microbadger.com/badges/image/cpuchain/cpuchaind.svg)](https://microbadger.com/#/images/cpuchain/cpuchaind)

Docker image that runs the CPUchain cpuchaind node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/1HngXg0), [Digital Ocean](http://bit.ly/18AykdD), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 100 GB to store the block chain files (and always growing!)
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on unadvertised (only shown within control panel) [Vultr SATA Storage 1024 MB RAM/250 GB disk instance @ $10/mo](http://bit.ly/vultrcpuchaind).  Vultr also *accepts CPUchain payments*!


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/cpuchain/docker-cpuchaind/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `cpuchaind-data` volume to persist the cpuchaind blockchain data, should exit immediately.  The `cpuchaind-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=cpuchaind-data
        docker run -v cpuchaind-data:/cpuchain --name=cpuchaind-node -d \
            -p 19706:19706 \
            -p 127.0.0.1:19707:19707 \
            cpuchain/cpuchaind

2. Verify that the container is running and cpuchaind node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        cpuchain/cpuchaind:latest     "cpu_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:19707->19707/tcp, 0.0.0.0:19706->19706/tcp   cpuchaind-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f cpuchaind-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).
