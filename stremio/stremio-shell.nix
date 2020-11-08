{ pkgs, mkDerivation, lib, qtbase, qt5, qtcreator, mpv, libGL, openssl, nodejs, wrapQtAppsHook }:

with pkgs;
mkDerivation rec {
  name = "stremio-shell";
  version = "v4.4.120";

  src = fetchFromGitHub {
    owner = "Stremio";
    repo = "stremio-shell";
    rev = "${version}";
    fetchSubmodules = true;
    sha256 = "0m68ck14kzg4gqmy2l3208pl5ibpggcrrj6r38gwrdwfn00scn11";
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
    maintainers = [
      
    ];
    platforms = platforms.linux;
  };
}
