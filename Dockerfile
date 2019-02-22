FROM docker:stable
RUN apk add --no-cache git py-pip python-dev gcc musl-dev libffi-dev openssl-dev make py-psutil

RUN pip install --upgrade pip
RUN pip install --upgrade ansible==2.5.* docker molecule pyOpenSSL PyYAML pytest==3.7.4 boto boto3
RUN pip install pywinrm[credssp]
RUN pip install git+https://github.com/ansible/ansible-lint.git && \
    ansible --version && \
    ansible-lint --version && \
    molecule --version
