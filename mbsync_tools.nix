with import <nixpkgs> {};
with pkgs.python3Packages;

buildPythonPackage rec {
  name = "mbsync_tools";
  src = fetchFromGitHub {
    owner = "gordonzola";
    repo = "mbsync_tools";
    rev = "v0.1.0";
    sha256 = "01jxz7bdlzaj0sxnr9pc92mv2p645a7d9cq0jgphmqgsi4fqbp00";
  };
  propagatedBuildInputs = [ pkgs.libsecret pkgs.python37Packages.secretstorage pkgs.python37Packages.keyring pkgs.python38Packages.secretstorage pkgs.python38Packages.keyring ];
}
