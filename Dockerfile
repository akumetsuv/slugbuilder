FROM progrium/cedarish
MAINTAINER Jeff Lindsay <progrium@gmail.com>

RUN useradd slugbuilder --home-dir /app

# allow user RW access to /app
RUN mkdir /app
RUN chown -R slugbuilder:slugbuilder /app

RUN apt-get update
RUN apt-get install -y libicu-dev

RUN DATABASE_URL=postgres://user:pass@127.0.0.1/does_not_exist_dbname

ADD ./builder/ /tmp/builder
RUN xargs -L 1 /tmp/builder/install-buildpack /tmp/buildpacks < /tmp/builder/buildpacks.txt
ENTRYPOINT ["/tmp/builder/build.sh"]
USER slugbuilder
