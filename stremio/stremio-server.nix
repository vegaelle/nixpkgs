{ pkgs, stdenv, lib, nodejs }:

with pkgs;
stdenv.mkDerivation rec {
  name = "stremio-server";
  version = "4.4.142";

  src = fetchurl {
    url = "https://dl.strem.io/four/v${version}/server.js";
    # sha256 = "01dc8l1xvwjjg94ycc0i1kwrfjrigs55g56d6a7l63ysl4xk26pa";
    sha256 = "0av15k15lbl2m50f2kg42bmi8xc8as7h1yb33i806bhv47fq71v1";
  };

  asarFile = fetchurl {
    url = "https://dl.strem.io/four/v${version}/stremio.asar";
    # sha256 = "1jkr377dlr5m5zm7n3lsvz3lmnqhipzb9r1szkrinfab865ck50g";
    sha256 = "130z5dph5bw56b2kaincrv5cvfgngqyjd6qfjc0j0nbmbzly3pcb";
  };

  buildInputs = [
    nodejs
  ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out
    cp ${src} $out/server.js
    chmod 644 $out/server.js
    cp ${asarFile} $out/stremio.asar
    chmod 644 $out/stremio.asar
    '';

  meta = with lib; {
    description = "The next generation media center";
    homepage = "https://stremio.com";
    platforms = platforms.linux;
  };
}
