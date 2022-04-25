
## Setup Client

1. Launch Cloud9
Create a new no-ingress EC2 instance for environment (access via Systems Manager)


2. Generate SSH

```shell
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```




```shell
./gen_key.sh
```

1. Download `authorized_keys` and `id_rsa`

```shell
mkdir -p ~/environment/ssh

cp -R ~/.ssh/* ~/environment/ssh
``` 