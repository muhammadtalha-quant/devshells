# DevShells

A repository that contains all the dev shells that I need frequently, not necessarily everytime.
This will work on pretty much every Linux Distribution (glibc only). But I use NixOS on daily basis so for that reason, some practices are followed only for NixOS and the x86 architecture.

> [!NOTE]
>
> - This flake is designed to provide development tools such as LSPs and Formatters, etc.
> - This flake does not handle secrets, services, scripts etc.
> - This flake is designed for personal portfolio projects, without making your global `$PATH` dirty.
> - For production use, I encourage you to use [devenv.sh](https://devenv.sh).

## Usage

### With Direnv (Recommended if you want cached environments)

This specific option only works on NixOS, NixOS WSL, or Other Distros with Home Manager. Place this exact block inside your `home.nix` and rebuild your environment.

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
inputs.devshells.inputs.nixpkgs.follows = "nixpkgs";
...

outputs = {nixpkgs, devshells, ...}@inputs: 
let 
    system = "x86_64-linux"; # IMPORTANT, otherwise it won't work
    # you can have systems = [ ... ]; but you would have to call this function in loop.
    pkgs = nixpkgs.legacyPackages.${system};
in
{
 devShells.${system}.default = devshells.lib.mkEnv { pkgs, «lang»};
    
    ...
};
```

Create a new file `.envrc` at root of project, and open it in your favourite editor and add lines `use_flake .#«lang»` as per your needs.

### With Native Nix (No Direnv, suitable for CI (manual caching required))

> To be documented 