{ config, lib, pkgs, inputs, ... }:

{
  imports =
    (import ./shell) ++
    [(import ./prog/helix.nix)];

  home = {
    username = "nixos";
    homeDirectory = "/home/nixos";
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };

}
