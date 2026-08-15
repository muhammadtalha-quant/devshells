{
  description = "A flake that defines development shells that I need frequently.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs: 
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  {
      devShells.${system} = {
           nix = pkgs.mkShellNoCC {
                packages = with pkgs; [
                  nil 
                  nixfmt 
                  statix
                ];            
           };
      };
  }
}
