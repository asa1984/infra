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
    { pkgs, ... }:
    {
      devShells.terraform = pkgs.mkShellNoCC {
        packages = [
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
    };
}
