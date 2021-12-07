with import <nixpkgs> {};
with pkgs.python3Packages;

buildPythonPackage rec {
  name = "mbsync_tools";
  src = fetchFromGitHub {
    owner = "vegaelle";
    repo = "mbsync_tools";
    rev = "v0.1.0";
    sha256 = "01jxz7bdlzaj0sxnr9pc92mv2p645a7d9cq0jgphmqgsi4fqbp00";
  };
  propagatedBuildInputs = [ pkgs.libsecret pkgs.python3Packages.secretstorage
  pkgs.python3Packages.keyring ];
}
