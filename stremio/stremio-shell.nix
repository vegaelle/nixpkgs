{ pkgs, mkDerivation, lib, qtbase, qt5, qtcreator, mpv, libGL, openssl, nodejs, wrapQtAppsHook }:

with pkgs;
mkDerivation rec {
  name = "stremio-shell";
  version = "4.4.137";

  src = fetchFromGitHub {
    owner = "Stremio";
    repo = "stremio-shell";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "0dzc4by9mxhijgccilha0wlgvjxwss4b015jfg39h9cdnwf5pphh";
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
    mkdir -p $out/bin
    make install
    ln -s $out/opt/stremio/stremio $out/bin/stremio-shell
    '';

  meta = with lib; {
    description = "The next generation media center";
    homepage = "https://stremio.com";
    platforms = platforms.linux;
  };
}
