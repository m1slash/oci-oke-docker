FROM python:3.7.2-stretch

ARG VERSION=0.2.0
ARG CLI_VERSION=2.9.8
ARG KUBECTL_VERSION=1.18.0
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="mislas87@gmail.com" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.version=$VERSION \
      org.label-schema.name="oci-oke-docker" \
      org.label-schema.description="OKE - Oracle Cloud Infrastructure CLI And Kubernetes CLI" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/mislas87/oci-oke-docker.git" \
      org.label-schema.docker.cmd="docker run -v \${HOME}/.oci:/root/.oci -v ${HOME}/.kube:/root/.kube -it mislas87/oci-oke:$VERSION"

WORKDIR /oci-cli

RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip \
    && apt-get install -y bash-completion

RUN set -ex \
    && wget -qO- -O oci-cli.zip "https://github.com/oracle/oci-cli/releases/download/v${CLI_VERSION}/oci-cli-${CLI_VERSION}.zip" \
    && unzip oci-cli.zip -d .. \
    && rm oci-cli.zip \
    && pip install oci_cli-*-py2.py3-none-any.whl

RUN yes | oci setup autocomplete

RUN set -ex \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/kubectl \
    && mkdir -p $HOME/.kube

RUN echo 'source /usr/share/bash-completion/bash_completion' >>~/.bashrc \
    && echo 'source <(kubectl completion bash)' >>~/.bashrc \
    && echo 'export KUBECONFIG=$HOME/.kube/config' >>~/.bashrc

ENTRYPOINT ["/usr/local/bin/oci"]
