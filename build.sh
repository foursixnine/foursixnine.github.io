#!/usr/bin/env bash
set -euo pipefail

source local-dev-environment.sh

if [[ ! -d $WORKDIR ]]; then
  echo "Path doesn't exist: ${WORKDIR}"
  exit 1
fi

if [[ ! -d $SITE_DIR ]]; then
  echo "Site path doesn't exist: ${SITE_DIR}"
  exit 1
fi

cleanup() {
  if [[ -f /.dockerenv || -f /run/.containerenv ]] && [[ ${KEEP_GEMS:-0} != 1 ]]; then
    rm -rf "$GEM_HOME"
  fi
}

trap cleanup EXIT

mkdir -p "$GEM_HOME" "$BUNDLE_APP_CONFIG" "$BUNDLE_CACHE_PATH" "$JEKYLL_CACHE_DIR"

gem install bundler

bundle config set --local path "$BUNDLE_PATH"
bundle config set --local cache_path "$BUNDLE_CACHE_PATH"
bundle install || true
exec bundle exec jekyll serve --incremental -o || true
