{
  description = "nvim config with dependencies"

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs, ... }: {
    configDir = self + "/.";
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.symlinkJoin {
      name = "nvim-deps";
      paths = with nixpkgs.legacyPackages.x86_64-linux; [
        tree-sitter
        ripgrep
        gcc
        git
      ];
    };
  };
}
