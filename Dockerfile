FROM public.ecr.aws/docker/library/node:16.17.0
ARG PROJECT_ROOT

RUN apt-get update && apt-get install -y \
  git \
  vim

# AWS CLI v2のインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip aws

# Nodeパッケージインストール
RUN npm install -g \
  npm-check-updates@16.1.3 \
  @aws-amplify/cli@10.0.0 \
  jsdoc@3.6.11