FROM public.ecr.aws/docker/library/node:16.17.0

RUN apt-get update && apt-get install -y \
  git \
  vim \
  java-common

# Amplify Mockを利用するためにJavaをインストール
RUN wget "https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.deb"\
  && dpkg -i amazon-corretto-11-x64-linux-jdk.deb \
  && rm amazon-corretto-11-x64-linux-jdk.deb

# AWS CLI v2のインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip aws

# NPMの更新
RUN npm install -g npm@8.19.2

USER node

# NPMのグローバルパッケージをnodeユーザのローカルに設定
RUN mkdir "${HOME}/.npm-packages"
RUN npm config set prefix "${HOME}/.npm-packages"
RUN echo 'NPM_PACKAGES="${HOME}/.npm-packages"' >> ~/.bashrc \
  && echo 'export PATH="$PATH:$NPM_PACKAGES/bin"' >> ~/.bashrc \
  && echo 'MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"'
RUN ["/bin/bash", "-c", "source ~/.bashrc"]

# Nodeパッケージインストール
RUN npm install -g \
  npm-check-updates@16.1.3 \
  @aws-amplify/cli@10.0.0 \
  jsdoc@3.6.11