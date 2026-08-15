{
  description = "A flake that defines development shells that I need frequently.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = {self, nixpkgs, ...}@inputs: 

  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lang = "nix";
  in
  {
    lib.mkEnv =
      {
        pkgs,
        lang,
      }:
      let
        languages = [
          "cpp"
          "python"
          "markdown"
          "toml"
          "yaml"
          "json"
          "typst"
          "nix"
        ];
      in
      if builtins.elem lang languages then
        (import ./shells/${lang}.nix) { inherit pkgs; }
      else
        pkgs.mkShellNoCC { };

    devShells.${system}.default = pkgs.mkShellNoCC {
      packages = with pkgs; [
        nil
        nixfmt 
        marksman
      ];
    };
  };
}
