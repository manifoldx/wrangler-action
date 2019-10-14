#!/bin/sh

set -e

export HOME="/github/workspace"
export NVM_DIR="/github/workspace/nvm"
export WRANGLER_HOME="/github/workspace"

# h/t https://github.com/elgohr/Publish-Docker-Github-Action
sanitize() {
  if [ -z "${1}" ]
  then
    >&2 echo "Unable to find ${2}. Did you set secrets.${2}?"
    exit 1
  fi
}

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

mkdir -p "$HOME/.wrangler"
chmod -R 777 "$HOME/.wrangler"

sanitize "${INPUT_CLOUDFLAREEMAIL}" "CLOUDFLARE_EMAIL"
sanitize "${INPUT_CLOUDFLAREAPI_KEY}" "CLOUDFLARE_API_KEY"

export CF_EMAIL="$INPUT_EMAIL"
export CF_API_KEY="$INPUT_APIKEY"

npm i @cloudflare/wrangler -g
npm i

ls

if [ -z "$INPUT_ENVIRONMENT" ]
then
  wrangler publish -e "$INPUT_ENVIRONMENT"
else
  wrangler publish
fi

