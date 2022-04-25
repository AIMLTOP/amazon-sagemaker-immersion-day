
## Setup Client

1. Launch Cloud9
Create a new no-ingress EC2 instance for environment (access via Systems Manager)

绑定安全组

2. Generate SSH

```shell
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```




```shell
./gen_key.sh
```

3. Download `authorized_keys` and `id_rsa`

```shell
mkdir -p ~/environment/ssh

cp -R ~/.ssh/* ~/environment/ssh
``` 


Step 1/19 : FROM ubuntu:18.04
toomanyrequests: You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limit


    # https://github.com/aws/sagemaker-training-toolkit/blob/master/ENVIRONMENT_VARIABLES.md
    hosts = json.loads(os.environ['SM_HOSTS'])
    gpus = len(hosts)*int(os.environ['SM_NUM_GPUS'])
    current_host = os.environ['SM_CURRENT_HOST']
    print("hosts: " + hosts)
    print("current host: " + current_host)
    print("gpus: " + gpus)

    print(" hostfile ")    
    os.system("cat /opt/ml/input/config/hostfile")
