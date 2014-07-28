FROM progrium/cedarish
MAINTAINER Jeff Lindsay <progrium@gmail.com>

RUN useradd slugbuilder --home-dir /app
RUN adduser slugbuilder sudo
RUN passwd -d slugbuilder

# allow user RW access to /app
RUN mkdir /app
RUN chown -R slugbuilder:slugbuilder /app

RUN apt-get update
RUN apt-get install -y libicu-dev
RUN apt-get install -y sudo
RUN chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo


ADD ./builder/ /tmp/builder
RUN xargs -L 1 /tmp/builder/install-buildpack /tmp/buildpacks < /tmp/builder/buildpacks.txt
ENTRYPOINT ["/tmp/builder/build.sh"]
USER slugbuilder
