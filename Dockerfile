FROM public.ecr.aws/docker/library/node:16.17.0

RUN apt-get update && apt-get install -y \
  sudo \
  software-properties-common \
  git \
  vim

RUN echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Amplify Mockを利用するためにJavaをインストール
RUN wget -O- https://apt.corretto.aws/corretto.key | apt-key add - \
  && add-apt-repository 'deb https://apt.corretto.aws stable main' \
  && apt-get update && apt-get install -y java-11-amazon-corretto-jdk

# AWS CLI v2のインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip aws

# Nodeパッケージインストール
RUN npm install -g \
  npm@8.19.2 \
  npm-check-updates@16.1.3 \
  @aws-amplify/cli@10.0.0 \
  jsdoc@3.6.11