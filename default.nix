{ pkgs ? import <nixpkgs> {} }:

with pkgs;
{
  stremio-shell = libsForQt5.callPackage ./stremio/stremio-shell.nix {};
  stremio-server = callPackage ./stremio/stremio-server.nix {};
  stremio-wrapper = callPackage ./stremio/stremio-wrapper.nix {};

  mbsync_tools = import ./mbsync_tools.nix;

  sgtk-menu = import ./sgtk-menu.nix;

  borgmatic = callPackage ./borgmatic/default.nix {};
  
  lightly = callPackage ./lightly.nix {};
}
