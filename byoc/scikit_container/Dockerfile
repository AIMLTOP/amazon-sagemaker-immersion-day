# Build an image that can do training and inference in SageMaker
# This is a Python 3 image that uses the nginx, gunicorn, flask stack
# for serving inferences in a stable way.

# FROM ubuntu:18.04 # has limit
FROM public.ecr.aws/lts/ubuntu:18.04_stable

MAINTAINER Amazon AI <sage-learner@amazon.com>


RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         python3-pip \
         python3-setuptools \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip

# Here we get all python packages.
# There's substantial overlap between scipy and numpy that we eliminate by
# linking them together. Likewise, pip leaves the install caches populated which uses
# a significant amount of space. These optimizations save a fair amount of space in the
# image, which reduces start up time.
RUN pip --no-cache-dir install numpy==1.16.2 scipy==1.2.1 scikit-learn==0.20.2 pandas flask gunicorn

# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"


##############################################################################
# SSH Daemon
##############################################################################

# Set up SSH server
RUN apt-get update && apt-get install -y --no-install-recommends openssh-server && \
    mkdir -p /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Copy SSH key.
RUN mkdir -p /root/.ssh/
COPY ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN printf "Host *\n  StrictHostKeyChecking no\n  UserKnownHostsFile /dev/null\n" >> /root/.ssh/config

RUN chmod 600 /root/.ssh -R

# # Client liveness, keep SSH client alive from server side
RUN echo "ClientAliveInterval 30" >> /etc/ssh/sshd_config
RUN cp /etc/ssh/sshd_config ${STAGE_DIR}/sshd_config && \
    sed "0,/^#Port 22/s//Port 22/" ${STAGE_DIR}/sshd_config > /etc/ssh/sshd_config

# Set up the program in the image
COPY decision_trees /opt/program
WORKDIR /opt/program

