# Could probably use a different image for source, doesn't need to be ruby
FROM ruby:3.2.2

WORKDIR /provision

ENV VERBOSE=true

RUN apt-get update --fix-missing && \
  apt-get -y install openssh-client openssh-server openssl

RUN ln -s /shared/ssh/id_rsa.pub /root/.ssh/authorized_keys

COPY *.sh .

HEALTHCHECK --interval=1s CMD pgrep sleep

CMD ["./boot.sh"]
