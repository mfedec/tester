# Could probably use a different image for source, doesn't need to be ruby
FROM ruby:3.2.2

WORKDIR /provision

ENV VERBOSE=true

RUN apt-get update --fix-missing && \
  apt-get -y install openssh-client openssl

RUN mkdir ssh && \
  ssh-keygen -t rsa -f ssh/id_rsa -N ""

RUN ln -s /shared/ssh /root/.ssh

COPY *.sh .

HEALTHCHECK --interval=1s CMD pgrep sleep

CMD ["./boot.sh"]
