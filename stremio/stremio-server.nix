{ pkgs, stdenv, lib, nodejs }:

with pkgs;
stdenv.mkDerivation rec {
  name = "stremio-server";
  version = "4.4.135";

  src = fetchurl {
    url = "https://dl.strem.io/four/v${version}/server.js";
    # sha256 = "01dc8l1xvwjjg94ycc0i1kwrfjrigs55g56d6a7l63ysl4xk26pa";
    sha256 = "1idxfdzp4zxqjihq4m520kp02kaqb8hw82w4y5vxajgc040mhq0m";
  };

  asarFile = fetchurl {
    url = "https://dl.strem.io/four/v4.4.111/stremio.asar";
    # sha256 = "1jkr377dlr5m5zm7n3lsvz3lmnqhipzb9r1szkrinfab865ck50g";
    sha256 = "1jkr377dlr5m5zm7n3lsvz3lmnqhipzb9r1szkrinfab865ck50g";
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
