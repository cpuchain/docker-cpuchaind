cpuchaind config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v cpuchaind-data:/cpuchain --name=cpuchaind-node -d \
            -p 19706:19706 \
            -p 127.0.0.1:19707:19707 \
            -e DISABLEWALLET=1 \
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            cpuchain/cpuchaind

Or you can use your very own config file like that:

        docker run -v cpuchaind-data:/cpuchain --name=cpuchaind-node -d \
            -p 19706:19706 \
            -p 127.0.0.1:19707:19707 \
            -v /etc/mycpuchain.conf:/cpuchain/.cpuchain/cpuchain.conf \
            cpuchain/cpuchaind
