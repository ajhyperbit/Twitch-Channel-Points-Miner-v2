{ pkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/25.05.tar.gz";
  }) { config.allowUnfree = true; }
}:

let
  ChannelPointsPackages = pkgs.python313.withPackages (ps: with ps; [
    colorama
    irc
    requests
    validators
    websocket-client
    emoji
    pillow
    python-dateutil
    pre-commit-hooks
    flask
    pandas
    pytz
    (ps.buildPythonPackage rec {
      pname = "millify";
      version = "0.1.1";

      src = ps.fetchPypi {
        inherit pname version;
        sha256 = "06kzb6349scv57x6yi6h9kvf1847pzsamr2w3fa3zlmnk3ffz7b1";
      };

      pyproject = true;
      buildInputs = [ ps.setuptools ];
    })
  ]);
in

pkgs.mkShell {
  buildInputs = [
    ChannelPointsPackages
  ];
}
