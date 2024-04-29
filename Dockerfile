FROM ubuntu:20.04

RUN <<EOF
  apt-get update
  apt-get install -y --no-install-recommends \
          vim \
          git \
          bc
EOF

RUN <<EOF
  useradd -s /bin/bash -m user
  groupadd docker
  usermod -aG docker user
EOF

USER user
WORKDIR /usr/src/app

RUN echo "alias ll='ls -la'" >> ~/.bashrc


CMD [ "bash" ]
