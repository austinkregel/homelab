FROM ubuntu:24.04
ENV GITHUB_USER=${GITHUB_USER:-"austinkregel"}

USER 0
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl git openssh-server openssh-sftp-server openssh-client redis-tools sudo supervisor && \
    rm -r /var/lib/apt/lists/* && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    curl -s https://install.zerotier.com | bash

RUN mkdir -p /var/run/sshd && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    curl https://github.com/${GITHUB_USER}.keys -o /root/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
