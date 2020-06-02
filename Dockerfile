FROM python:3.8-slim-buster


# pip search awscli | grep -o "^awscli (.*)" | sed -n -e 's/^awscli (\(.*\))/\1/p'
ARG AWSCLI_VERSION=1.18.69

# curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ARG KUBERNETES_VERSION=v1.16.10

# curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4
ARG KOPS_VERSION=v1.16.3

## Kubectl + AWS + KOPS
RUN apt update \
    && apt install -y bash jq ca-certificates less curl openssl tmux coreutils git libarchive-tools \
    && pip install --upgrade --no-cache-dir awscli==$AWSCLI_VERSION \
    && curl -L "https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64" -o /usr/local/bin/kops && chmod a+x /usr/local/bin/kops \
    && curl -L "https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl \
    && rm -rf /var/cache/apt/*
