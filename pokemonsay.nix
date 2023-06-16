{ lib, stdenv, fetchFromGitHub, python3, texinfo, makeWrapper }:

stdenv.mkDerivation rec {
  pname = "pokemonsay";
  version = "2017-03-26";

  src = fetchFromGitHub {
    owner = "possatti";
    repo = "pokemonsay";
    rev = "88e82d048fd74f464bf9e02b762abb766a18b3a3";
    sha256 = lib.fakeSha256;
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 texinfo cowsay ];

  inherit python3;

  installPhase = ''
    find -type f -name "*.py" | xargs sed -i "s@/usr/bin/env python3@$python3/bin/python3@g"
    substituteInPlace setup.py --replace \
        "fileout.write(('#!/usr/bin/env %s\n' % env).encode('utf-8'))" \
        "fileout.write(('#!%s/bin/%s\n' % (os.environ['python3'], env)).encode('utf-8'))"
    python3 setup.py --prefix=$out --freedom=partial install \
        --with-shared-cache=$out/share/ponysay \
        --with-bash
  '';

  meta = with lib; {
    description = "Cowsay reimplemention for ponies";
    homepage = "https://github.com/erkin/ponysay";
    license = licenses.gpl3;
    maintainers = with maintainers; [ bodil ];
    platforms = platforms.unix;
  };
}
