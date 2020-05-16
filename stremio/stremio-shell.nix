{ pkgs, mkDerivation, lib, qtbase, qt5, qtcreator, mpv, libGL, openssl, nodejs, wrapQtAppsHook }:

with pkgs;
mkDerivation rec {
  name = "stremio-shell";
  version = "4.4.106";

  src = fetchFromGitHub {
    owner = "Stremio";
    repo = "stremio-shell";
    rev = "${version}";
    fetchSubmodules = true;
    sha256 = "05lp1iq08n8wh7m12d9pz9lg6hwc0d936kmlzvdxwxbnm86cxy54";
  };

  serverFile = fetchurl {
    url = "https://dl.strem.io/four/v4.4.111/server.js";
    sha256 = "01dc8l1xvwjjg94ycc0i1kwrfjrigs55g56d6a7l63ysl4xk26pa";
  };

  asarFile = fetchurl {
    url = "https://dl.strem.io/four/v4.4.111/stremio.asar";
    sha256 = "1jkr377dlr5m5zm7n3lsvz3lmnqhipzb9r1szkrinfab865ck50g";
  };

  globalOutputDir = "${placeholder "out"}";

  stremioCommand = pkgs.writeShellScriptBin "stremio" ''
    ${pkgs.nodejs}/bin/node ${serverFile} &
    serverPid=$!
    ${globalOutputDir}/bin/stremio-shell
    kill $serverPid
    '';

  stremioItem = makeDesktopItem {
    name = "Stremio";
    exec = "stremio";
    comment = "${meta.description}";
    desktopName = "Stremio";
    categories = "AudioVideo;Video;Player;TV;";
    icon = "$out/images/stremio.svg";
  };

  nativeBuildInputs = [ wrapQtAppsHook ];

  buildInputs = [
    qtbase
    qt5.full
    qtcreator
    mpv
    libGL
    openssl
    nodejs
  ];

  # qtWrapperArgs = [ ''--prefix PATH : /opt/stremio/stremio'' ];

  configurePhase = "qmake PREFIX=$out";

  buildPhase = "make";

  installPhase = ''
    mkdir -p $out/bin
    make install
    ln -s $out/opt/stremio/stremio $out/bin/stremio-shell
    cp ${stremioCommand}/bin/stremio $out/bin/stremio
    cp ${serverFile} $out/opt/stremio/server.js
    chmod 644 $out/opt/stremio/server.js
    cp ${asarFile} $out/opt/stremio/stremio.asar
    chmod 644 $out/opt/stremio/stremio.asar
    '';

  meta = with lib; {
    description = "The next generation media center";
    homepage = "https://stremio.com";
    maintainers = [
      
    ];
    platforms = platforms.linux;
  };
}


