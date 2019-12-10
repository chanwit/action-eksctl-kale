FROM python:3.8-alpine

LABEL "com.github.actions.name"="eksctl-kale-cmd"
LABEL "com.github.actions.description"="eksctl is a simple CLI tool for creating clusters on EKS"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/chanwit/action-eksctl-kale"
LABEL "homepage"="https://github.com/chanwit/action-eksctl-kale"
LABEL "maintainer"="Chanwit Kaewkasi <chanwit@weave.works>"

COPY entrypoint.sh /entrypoint.sh

RUN apk add --update --no-cache curl openssl git gcc musl-dev libffi-dev libressl-dev \
    && curl -s -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator \
    && curl -s -o /tmp/aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator.sha256 \
    && openssl sha1 -sha256 /usr/local/bin/aws-iam-authenticator \
    && curl -s --location "https://github.com/weaveworks/eksctl/releases/download/0.9.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin \
    && chmod +x /entrypoint.sh

RUN pip3 install --upgrade --user awscli

RUN pip3 install git+https://github.com/chanwit/kale

ENTRYPOINT /entrypoint.sh