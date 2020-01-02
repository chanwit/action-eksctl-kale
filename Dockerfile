FROM python:3.6-alpine

LABEL "com.github.actions.name"="eksctl-kale-cmd"
LABEL "com.github.actions.description"="EKSctl and Kubeflow Kale"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/chanwit/action-eksctl-kale"
LABEL "homepage"="https://github.com/chanwit/action-eksctl-kale"
LABEL "maintainer"="Chanwit Kaewkasi <chanwit@weave.works>"

RUN apk add --update --no-cache curl openssl git gcc musl-dev libffi-dev libressl-dev \
    && curl -s -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator \
    && curl -s -o /tmp/aws-iam-authenticator.sha256 https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator.sha256 \
    && openssl sha1 -sha256 /usr/local/bin/aws-iam-authenticator \
    && curl -s --location "https://github.com/weaveworks/eksctl/releases/download/0.9.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin

RUN pip3 install awscli --upgrade
RUN pip3 install kfp==0.1.31.1
RUN pip3 install \
	six \
	dill==0.3.1.1 \
	git+https://github.com/chanwit/kale

ADD https://storage.googleapis.com/kubernetes-release/release/v1.14.7/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

COPY entrypoint.sh /entrypoint.sh
RUN  chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh