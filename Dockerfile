FROM docker:latest

ARG ANSIBLE_VERSION=2.9.*
ARG MOLECULE_VERSION=3.*
ARG ANSIBLE_LINT_VERSION=5.*

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV MOLECULE_VERSION=${MOLECULE_VERSION}
ENV ANSIBLE_LINT_VERSION=${ANSIBLE_LINT_VERSION}

LABEL maintainer="team@lean-delivery.com"

RUN apk add --update --no-cache git gcc musl-dev libffi-dev openssl-dev make py3-configobj \
  py3-pip py3-setuptools python3 python3-dev openssh-client yamllint
RUN /usr/bin/python3 -m pip install --no-cache --upgrade pip
RUN apk add --update --no-cache rust cargo rsync


RUN /usr/bin/python3 -m pip install --no-cache setuptools wheel \
  ansible==${ANSIBLE_VERSION} molecule==${MOLECULE_VERSION} molecule-docker molecule-ec2 ansible-lint==${ANSIBLE_LINT_VERSION} \
  pywinrm[credssp] boto boto3
RUN ansible-galaxy collection install community.molecule && \
  ansible --version && \
  ansible-lint --version && \
  yamllint --version && \
  molecule --version
