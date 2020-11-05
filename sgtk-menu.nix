with import <nixpkgs> {};
with pkgs.python3Packages;

buildPythonApplication rec {
  name = "sgtk-menu";
  src = fetchFromGitHub {
    owner = "nwg-piotr";
    repo = "sgtk-menu";
    rev = "v1.4.1";
    sha256 = "sha256:1b5bp0ln493c8y63hx0dywjbv4k7z2qgdiy89c99mxdpznb0g3bd";
  };

  strictDeps = false;

  buildInputs = [ gobject-introspection wrapGAppsHook ];

  propagatedBuildInputs = with python3.pkgs; [
    gtk3
    systemd
    gobject-introspection
    # (python3.withPackages (p: with p; [ pygobject3 cairocffi pycairo setuptools ]))
    pygobject3 pycairo setuptools
  ];

  preBuild = "HOME=$TEMPDIR";

  meta = with lib; {
    description = "GTK launchers for sway & other WMs w/ menu, dmenu, application grid and button bar";
    homepage = "https://github.com/nwg-piotr/sgtk-menu";
    platforms = platforms.linux;
  };
}

