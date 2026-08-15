{ pkgs }:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    nil
    nixfmt
  ];
}
