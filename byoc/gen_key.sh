#!/usr/bin/env bash

keyFile=$1
keyFile=${keyFile:-~\/.ssh\/id_rsa}

echo "Key File: $keyFile "

# Generate SSH Key
ssh-keygen -q -t rsa -N '' -f $keyFile

cat $keyFile.pub >> ~/.ssh/authorized_keys