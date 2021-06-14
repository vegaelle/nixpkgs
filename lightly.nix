{ stdenv, fetchFromGitHub, lib, pkgs }:

stdenv.mkDerivation rec {
  pname = "lightly-kde-theme";
  version = "v0.4.1";

  src = fetchFromGitHub {
    owner = "Luwx";
    repo = "Lightly";
    rev = version;
    sha256 = "0qkjzgjplgwczhk6959iah4ilvazpprv7yb809jy75kkp1jw8mwk";
  };

  # buildInputs = with pkgs; [
  #   # libkf5config-dev libkdecorations2-dev libqt5x11extras5-dev
  #   # qtdeclarative5-dev extra-cmake-modules libkf5guiaddons-dev
  #   # libkf5configwidgets-dev libkf5windowsystem-dev libkf5coreaddons-dev
  #   # libkf5iconthemes-dev gettext qt3d5-dev
  #   libsForQt5.kdecoration
  #   libsForQt5.qt5.qtx11extras
  #   libsForQt5.qt5.qtdeclarative
  #   libsForQt5.kguiaddons
  #   libsForQt5.kconfigwidgets
  #   libsForQt5.kwindowsystem
  #   libsForQt5.kcoreaddons
  #   libsForQt5.kiconthemes
  #   gettext
  # ];

  dontWrapQtApps = true;

  outputs = [ "out" "dev" ];
  
  nativeBuildInputs = with pkgs; [ cmake extra-cmake-modules ];

  buildInputs = with pkgs; [
    libsForQt5.qtbase
    libsForQt5.qt5.qtx11extras
    libsForQt5.qt5.qtdeclarative
    libsForQt5.kcoreaddons
    libsForQt5.kdecoration
    libsForQt5.kiconthemes
    libsForQt5.kconfigwidgets
    libsForQt5.kguiaddons
    libsForQt5.kwindowsystem
  ];

  makeFlags = [ "PREFIX=$(out)" ];

  # Make this a fixed-output derivation
  outputHashMode = "recursive";
  outputHashAlgo = "sha256";
  ouputHash = "0000000000000000000000000000000000000000000000000";

  meta = {
    description = "A modern style for qt applications. ";
    homepage = "https://github.com/Luwx/Lightly";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.all;
  };
}
