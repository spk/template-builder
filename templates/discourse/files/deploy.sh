#!/bin/bash

unset NPM_CONFIG_PREFIX
export NVM_DIR="$PLATFORM_APP_DIR/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use $NODE_VERSION
#if [ ! -f install/platform.installed ]; then
    # Copy the public files into a writeable directory before running the migration
    # on the initial install. After the first deploy this can be put off to post_deploy.
    rsync -avq --update --ignore-errors _public/ public/
    # It's unclear why these need to be precompiled in deploy rather than post-deploy
    # the first time the site is deployed, but they do.
    bundle exec rake db:migrate -q
    bundle exec rake assets:precompile -q
    touch install/platform.installed
#fi

