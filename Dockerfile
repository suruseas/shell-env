FROM ubuntu:20.04

# 実行ユーザ指定
ARG user

# manコマンド使いたかったら unminimize コマンドを別途実行してください。時間がかかるのでここではskipします。

RUN <<EOF
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y git tzdata
  apt-get install -y --no-install-recommends \
          vim \
          git \
          sudo \
          man-db \
          locales \
          bc \
          gawk \
          tzdata \
          imagemagick
EOF

RUN locale-gen ja_JP.UTF-8

RUN <<EOF
  useradd -s /bin/bash -m ${user:-user}
  groupadd docker
  usermod -aG docker ${user:-user}
EOF

RUN echo "${user:-user} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
# git cloneできるように
RUN apt-get install -y --reinstall ca-certificates

RUN mkdir -p /usr/src/app/shellgei160 && \
    chown ${user:-user}:${user:-user} /usr/src/app/shellgei160

USER ${user:-user}
WORKDIR /usr/src/app

RUN echo "alias ll='ls -la'" >> ~/.bashrc
RUN echo "export LANG=ja_JP.UTF-8" >> ~/.bashrc

CMD [ "bash" ]
