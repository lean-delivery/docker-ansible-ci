FROM docker:stable

LABEL maintainer="team@lean-delivery.com"

RUN apk add --no-cache git py-pip python-dev gcc musl-dev libffi-dev openssl-dev make
RUN apk add --no-cache openssh-client

RUN pip install --upgrade pip
RUN pip install molecule
RUN pip install --upgrade ansible==2.5.* docker pyOpenSSL PyYAML pytest==3.7.4
RUN pip install pywinrm[credssp] boto boto3
RUN pip install git+https://github.com/ansible/ansible-lint.git && \
    ansible --version && \
    ansible-lint --version && \
    molecule --version
