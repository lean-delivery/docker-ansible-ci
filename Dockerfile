FROM docker:latest

ARG ANSIBLE_VERSION=2.9.*
ARG MOLECULE_VERSION=3.2.*

ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ENV MOLECULE_VERSION=${MOLECULE_VERSION}

LABEL maintainer="team@lean-delivery.com"

RUN apk add --update --no-cache git gcc musl-dev libffi-dev openssl-dev make py3-configobj \
  py3-pip py3-setuptools python3 python3-dev openssh-client rust


RUN /usr/bin/python3 -m pip install --no-cache --upgrade pip setuptools wheel \
  ansible==$ANSIBLE_VERSION molecule==$MOLECULE_VERSION molecule-docker molecule-ec2 ansible-lint \
  pywinrm[credssp] boto boto3
RUN ansible-galaxy collection install community.molecule && \
  ansible --version && \
  ansible-lint --version && \
  molecule --version
