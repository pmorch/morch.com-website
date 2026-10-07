# morch.com-website

This is the repository behind https://www.morch.com. It uses
[Hugo](https://gohugo.io/). See [HowtoHugo](content/howto-hugo.md) for how to
use Hugo.

Pushes to `master` are built and deployed by Cloudflare Workers Builds
(Worker `morch-com-website`): it runs `./cf-build.sh` (downloads Hugo and
builds into `public/`) and then `npx wrangler deploy`, which serves `public/`
as static assets per `wrangler.jsonc`. The Worker has `www.morch.com` and
`morch.com` as custom domains; Cloudflare redirect rules send `http://` to
`https://` and `morch.com` to `www.morch.com`.

For local work, `direnv allow` (or `nix develop`) provides the same Hugo
version via `flake.nix`; then run `hugo server`. Keep the Hugo version in
`flake.nix` and `cf-build.sh` in sync.
