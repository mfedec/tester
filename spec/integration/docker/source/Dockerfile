# Could probably use a different image for source, doesn't need to be ruby
FROM ruby:3.2.2

WORKDIR /provision

RUN mkdir /root/.ssh && ln -s /shared/ssh/id_rsa.pub /root/.ssh/authorized_keys

COPY *.sh .

RUN ./ubuntu_setup.sh

HEALTHCHECK --interval=1s CMD pgrep sshd

CMD ["/usr/sbin/sshd", "-D"]
