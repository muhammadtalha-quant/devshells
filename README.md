# DevShells

A repository that contains all the dev shells that I need frequently, not necessarily everytime.
This will work on pretty much every Linux Distribution (glibc only). But I use NixOS on daily basis so for that reason, some practices are followed only for NixOS and the x86 architecture.

## Usage

### With Direnv (Recommended if you want cached environments)

This specific option only works on NixOS, NixOS WSL, or Other Distros with Home Manager. Place this exact block inside your `home.nix`.

```nix
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;  
    };
```

In your downstream flake.nix, place this.

```nix
inputs.devshells.url = "https://github.com/muhammadtalha-quant/devshells"; 
...

outputs = {nixpkgs, devshells, ...}@inputs: 
let 
    system = "x86_64-linux"; # IMPORTANT, otherwise it won't work
    pkgs = nixpkgs.legacyPackages.${system}; # or use flake parts instead
in
{
 devShells.${system}.default = devshells.lib.mkEnv { pkgs, «lang»};
    
    ...
};
```

### With Native Nix (No Direnv, suitable for CI (manual caching required))
