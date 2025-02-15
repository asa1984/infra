{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      imports = [
        ./pkgs/flake-module.nix
        ./terraform/flake-module.nix
      ];
    };
}
