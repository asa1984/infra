let
  convert2Tofu =
    provider:
    provider.override (prev: {
      homepage =
        builtins.replaceStrings
          [ "registry.terraform.io/providers" ]
          [
            "registry.opentofu.org"
          ]
          prev.homepage;
    });
in
{
  perSystem =
    { pkgs, self', ... }:
    {
      devShells.terraform = pkgs.mkShellNoCC {
        buildInputs = [
          (pkgs.opentofu.withPlugins (
            p:
            builtins.map convert2Tofu [
              p.cloudflare
              p.github
              p.vultr
            ]
          ))
        ];
      };
      packages.terraform-ci = pkgs.buildEnv {
        name = "terraform-ci";
        paths = self'.devShells.terraform.buildInputs ++ [
          pkgs.jq
          self'.packages.tfcmt
        ];
      };
    };
}
