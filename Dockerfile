FROM python:3.8-alpine

ARG ANSIBLE_VERSION=2.8.*
ARG MOLECULE_VERSION=2.22

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV MOLECULE_VERSION=${MOLECULE_VERSION}

LABEL maintainer="team@lean-delivery.com"

RUN apk add -U bash jq git
RUN apk add --no-cache gcc rsync make openssl-dev libffi-dev musl-dev linux-headers openssh-client \
    && rm -rf /var/cache/apk/*
RUN pip3 install --no-cache --upgrade pip wheel pywinrm[credssp] boto boto3 \
    ansible[azure]==$ANSIBLE_VERSION docker pyOpenSSL PyYAML pytest molecule==$MOLECULE_VERSION \
    ansible-lint==4.* && ln -s /usr/bin/python3 /usr/bin/python
    # ansible --version && \
    # ansible-lint --version && \
    # molecule --version

CMD [ "molecule", "--version" ]