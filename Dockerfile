FROM docker:stable

ARG ANSIBLE_VERSION=2.8.*
ARG MOLECULE_VERSION=2.22

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV MOLECULE_VERSION=${MOLECULE_VERSION}

LABEL maintainer="team@lean-delivery.com"

RUN apk add --no-cache git py-pip python-dev gcc musl-dev libffi-dev openssl-dev make
RUN apk add --no-cache openssh-client

RUN pip install --upgrade pip
RUN pip install git+git://github.com/ansible/molecule@$MOLECULE_VERSION
RUN pip install --upgrade ansible==$ANSIBLE_VERSION docker pyOpenSSL PyYAML pytest
RUN pip install pywinrm[credssp] boto boto3
RUN pip install git+https://github.com/ansible/ansible-lint.git && \
    ansible --version && \
    ansible-lint --version && \
    molecule --version