{ lib, pkgs, config, modulesPath, ... }:

with lib;
let nixos-wsl = import ./nixos-wsl;
in {
  imports = [ "${modulesPath}/profiles/minimal.nix" nixos-wsl.nixosModules.wsl ]
    ++ [ (import ./fonts.nix) ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  users.users.nixos = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Hugo";
    extraGroups = [ "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    neofetch
    fzf
    texlive.combined.scheme-full
    unzip
    gcc
    zathura
    python38
    python311
    cargo
    clang
    # rustc
    # llvmPackages.bintools
    rustup
    gh
    exercism
    nodejs
    ripgrep

    ## LSP
    rust-analyzer
    rnix-lsp
    lua-language-server

    ## Debug
    # lldb_16
    # libclang
    # lldb_9
    llvmPackages_rocm.lldb
    llvmPackages_rocm.clang-unwrapped
    mold

    ## Format
    stylua
    rustfmt
    nixfmt

  ];

  system.stateVersion = "22.05";
}
