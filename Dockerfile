FROM ubuntu:20.04

# 実行ユーザ指定
ARG user

# manコマンド使いたかったら unminimize コマンドを別途実行してください。時間がかかるのでここではskipします。

RUN <<EOF
  apt-get update
  apt-get install -y --no-install-recommends \
          vim \
          git \
          sudo \
          man-db \
          bc
EOF

RUN <<EOF
  useradd -s /bin/bash -m ${user:-user}
  groupadd docker
  usermod -aG docker ${user:-user}
EOF

RUN echo "${user:-user} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ${user:-user}
WORKDIR /usr/src/app

RUN echo "alias ll='ls -la'" >> ~/.bashrc


CMD [ "bash" ]
