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

  nativeBuildInputs = [ wrapQtAppsHook ];

  buildInputs = [
    qtbase
    qt5.full
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
    maintainers = [
      
    ];
    platforms = platforms.linux;
  };
}
