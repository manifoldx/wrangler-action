FROM node:14.16.1-buster

ENV NODE_ENV='production'

ENV XDG_CONFIG_HOME /github/workspace
ENV WRANGLER_HOME /github/workspace


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
