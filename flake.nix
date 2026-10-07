{
  description = "www.morch.com Hugo site";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # nixpkgs lags upstream; bump version + both hashes to upgrade.
        # Keep in sync with HUGO_VERSION in cf-build.sh.
        hugo = pkgs.hugo.overrideAttrs (old: rec {
          version = "0.167.0";
          src = pkgs.fetchFromGitHub {
            owner = "gohugoio";
            repo = "hugo";
            tag = "v${version}";
            hash = "sha256-T6dEgvY1Akt+GUWdNvVTjkmtM/MwW9HX/v4Ra+jmZKY=";
          };
          vendorHash = "sha256-67v7yJx2q/YrY5yvlDXmNzH1oFnM+9nN18QgjPhT3tg=";
        });
      in
      {
        packages.hugo = hugo;
        devShells.default = pkgs.mkShell {
          packages = [ hugo ];
        };
      });
}
