{ pkgs ? import <nixpkgs> {} }:
let
  beamPkg = pkgs.beam.packagesWith pkgs.erlang;
  elixir = beamPkg.elixir.override {
    version = "1.12.2";
    sha256 = "1rwmwnqxhjcdx9niva9ardx90p1qi4axxh72nw9k15hhlh2jy29x";
  };

in
pkgs.mkShell {
  nativeBuildInputs = [
    elixir
    pkgs.inotify-tools
    pkgs.nodejs-14_x
    #pkgs.postgresql_12
  ];
  shellHook           = ''
    mix local.hex --if-missing
    mix archive.install hex phx_new --force
  '';
}
