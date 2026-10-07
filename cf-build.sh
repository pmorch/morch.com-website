#!/usr/bin/env bash
# Build command for Cloudflare Workers Builds. Keep HUGO_VERSION in sync with flake.nix.
set -euo pipefail
HUGO_VERSION=0.167.0
curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz" \
  | tar -xz -C /tmp hugo
/tmp/hugo --gc --minify
