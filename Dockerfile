FROM docker:latest

ARG ANSIBLE_VERSION=2.9.*
ARG MOLECULE_VERSION=3.*

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV MOLECULE_VERSION=${MOLECULE_VERSION}

LABEL maintainer="team@lean-delivery.com"

RUN apk add --update --no-cache git gcc musl-dev libffi-dev openssl-dev make py3-configobj py3-pip py3-setuptools python3 python3-dev
RUN apk add --update --no-cache openssh-client


RUN /usr/bin/python3 -m pip install --no-cache --upgrade pip setuptools wheel
#RUN pip3 install git+https://github.com/ansible/molecule@$MOLECULE_VERSION
#RUN pip3 install \
#   --index-url https://test.pypi.org/simple \
#   --extra-index-url https://pypi.org/simple \
#   molecule==2.21.dev46
RUN /usr/bin/python3 -m pip install --upgrade ansible==$ANSIBLE_VERSION docker pyOpenSSL PyYAML
RUN /usr/bin/python3 -m pip install --upgrade pywinrm[credssp] boto boto3
RUN /usr/bin/python3 -m pip install --upgrade --ignore-installed distlib molecule==$MOLECULE_VERSION
RUN /usr/bin/python3 -m pip install git+https://github.com/ansible/ansible-lint.git && \
    ansible --version && \
    ansible-lint --version && \
    molecule --version
