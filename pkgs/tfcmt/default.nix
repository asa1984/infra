{
  stdenvNoCC,
}:
let
  version = "4.14.2";
  srcs = {
    aarch64-darwin = builtins.fetchTarball {
      url = "https://github.com/suzuki-shunsuke/tfcmt/releases/download/v${version}/tfcmt_darwin_arm64.tar.gz";
      sha256 = "sha256:1kpvwr924sjxxfwijp7m7p0d7bj11l1sapklpcb0si3q9i2dyl8c";
    };
    aarch64-linux = builtins.fetchTarball {
      url = "https://github.com/suzuki-shunsuke/tfcmt/releases/download/v${version}/tfcmt_linux_arm64.tar.gz";
      sha256 = "sha256:1dizkwy0rqv9ydw8bg78q1plvjcljihl1c5cy8r1jl05hpf2cr25";
    };
    x86_64-darwin = builtins.fetchTarball {
      url = "https://github.com/suzuki-shunsuke/tfcmt/releases/download/v${version}/tfcmt_darwin_amd64.tar.gz";
      sha256 = "sha256:1bycnvkc5s9bf6fzjl9a47r09f0hvdvm6f896q0cvrfy93khq2nj";
    };
    x86_64-linux = builtins.fetchTarball {
      url = "https://github.com/suzuki-shunsuke/tfcmt/releases/download/v${version}/tfcmt_linux_amd64.tar.gz";
      sha256 = "sha256:17ka1dn7f5770gymlhfn6ajazdnap6r0ybcj8k39kkysns0109qi";
    };
  };
in
stdenvNoCC.mkDerivation {
  inherit version;
  pname = "tfcmt";
  src = srcs.${stdenvNoCC.system};
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp tfcmt $out/bin
  '';
}
