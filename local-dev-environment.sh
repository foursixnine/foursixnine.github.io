export WORKDIR="."
export RBENV_ROOT=$WORKDIR/.rbenv
export SITE_DIR=${SITE_DIR:-$WORKDIR}
export GEM_HOME=${GEM_HOME:-$WORKDIR/.gems}
export GEM_PATH=${GEM_PATH:-$GEM_HOME}
export PATH=$GEM_HOME/bin:$PATH
export BUNDLE_GEMFILE=${BUNDLE_GEMFILE:-$SITE_DIR/Gemfile}
export BUNDLE_PATH=${BUNDLE_PATH:-$GEM_HOME}
export BUNDLE_APP_CONFIG=${BUNDLE_APP_CONFIG:-$WORKDIR/.bundle}
export BUNDLE_CACHE_PATH=${BUNDLE_CACHE_PATH:-$WORKDIR/vendor/cache}
export JEKYLL_CACHE_DIR=${JEKYLL_CACHE_DIR:-$WORKDIR/.jekyll-cache}
eval "$(rbenv init - zsh)"
rbenv local 3.3.12
