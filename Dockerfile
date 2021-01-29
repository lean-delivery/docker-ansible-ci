FROM docker:stable

ARG ANSIBLE_VERSION=2.9.*
ARG MOLECULE_VERSION=3.*

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV MOLECULE_VERSION=${MOLECULE_VERSION}

LABEL maintainer="team@lean-delivery.com"

RUN apk add --no-cache git python3-dev gcc musl-dev libffi-dev openssl-dev make
RUN apk add --no-cache openssh-client

RUN pip install --no-cache --upgrade pip setuptools wheel
#RUN pip3 install git+https://github.com/ansible/molecule@$MOLECULE_VERSION
#RUN pip3 install \
#   --index-url https://test.pypi.org/simple \
#   --extra-index-url https://pypi.org/simple \
#   molecule==2.21.dev46
RUN pip install molecule==$MOLECULE_VERSION
RUN pip install --upgrade ansible==$ANSIBLE_VERSION docker pyOpenSSL PyYAML pytest
RUN pip install pywinrm[credssp] boto boto3
RUN pip install git+https://github.com/ansible/ansible-lint.git && \
    ansible --version && \
    ansible-lint --version && \
    molecule --version
