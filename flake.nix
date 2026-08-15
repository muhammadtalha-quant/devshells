{
  description = "A flake that defines development shells that I need frequently.";

  outputs = {
    lib.mkEnv =
      {
        pkgs,
        lang,
      }:
      let
        languages = [
          # "cpp"
          # "python"
          # "markdown"
          # "toml"
          # "yaml"
          # "json"
          # "typst"
          "nix"
        ];
      in
      if builtins.elem lang languages then
        (import ./shells/${lang}) { inherit pkgs; }
      else
        pkgs.mkShellNoCC { };
  };
}
