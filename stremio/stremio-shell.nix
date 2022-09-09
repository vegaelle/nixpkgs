{ pkgs, mkDerivation, lib, qtbase, qt5, qtcreator, mpv, libGL, openssl, nodejs, wrapQtAppsHook }:

with pkgs;
mkDerivation rec {
  name = "stremio-shell";
  version = "4.4.142";

  src = fetchFromGitHub {
    owner = "Stremio";
    repo = "stremio-shell";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "00l1d567ppl29kghyg38681x9cl9zk4lrwzhw33w62q8c4b96arv";
  };

  nativeBuildInputs = [ wrapQtAppsHook ];

  buildInputs = [
    qtbase
    # qt5.full
    qt5.qtquickcontrols2
    qt5.qtwebengine
    qtcreator
    mpv
    libGL
    openssl
  ];

  configurePhase = "qmake PREFIX=$out";

  buildPhase = "make";

  installPhase = ''
    mkdir -p $out/bin $out/images
    make install
    ln -s $out/opt/stremio/stremio $out/bin/stremio-shell
    ln -s $src/images/stremio.svg $out/images
    '';

  meta = with lib; {
    description = "The next generation media center";
    homepage = "https://stremio.com";
    platforms = platforms.linux;
  };
}
