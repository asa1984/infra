{ fetchFromGitHub, buildGoModule }:
buildGoModule rec {
  pname = "tfcmt";
  version = "4.14.2";

  src = fetchFromGitHub {
    owner = "suzuki-shunsuke";
    repo = "tfcmt";
    tag = "v${version}";
    hash = "sha256-JGk4xcMeVtLT2h6KGFw6G8xEB6Qz6uFoSZrji+YLtK4=";
  };

  vendorHash = "sha256-t/O7nUYnb8NZyztRjg99UDlbnshJhrgj2ACi5YAFLn0=";
}
