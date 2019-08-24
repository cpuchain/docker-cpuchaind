#!/bin/bash
set -e

testAlias+=(
	[cpuchaind:trusty]='cpuchaind'
)

imageTests+=(
	[cpuchaind]='
		rpcpassword
	'
)
