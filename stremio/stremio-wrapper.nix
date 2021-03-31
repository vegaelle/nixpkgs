{ pkgs, stdenv, lib }:

let 
  stremio-shell = pkgs.libsForQt5.callPackage ./stremio-shell.nix {};
  stremio-server = pkgs.callPackage ./stremio-server.nix {};
in
with pkgs;
stdenv.mkDerivation rec {
  name = "stremio-wrapper";
  version = "4.4.135";

  src = pkgs.writeShellScriptBin "stremio" ''
    ${pkgs.nodejs}/bin/node ${stremio-server}/server.js &
    serverPid=$!
    ${stremio-shell}/bin/stremio-shell
    kill $serverPid
    '';

  stremioItem = makeDesktopItem {
    name = "Stremio";
    exec = "${src}/bin/stremio";
    comment = "${meta.description}";
    desktopName = "Stremio";
    categories = "AudioVideo;Video;Player;TV;";
    icon = "${stremio-shell}/images/stremio.svg";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/bin/stremio $out/bin/stremio
    '';

  meta = with lib; {
    description = "The next generation media center";
    homepage = "https://stremio.com";
    platforms = platforms.linux;
  };
}
