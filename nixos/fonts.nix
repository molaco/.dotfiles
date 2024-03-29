{ config, lib, pkgs, ... }:

{
fonts = {
  fonts = with pkgs; [
    material-design-icons
    emacs-all-the-icons-fonts
    inter
    material-icons
    material-design-icons
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    twemoji-color-font
    fira-code
    fira-code-symbols
    # (nerdfonts.override {fonts = [ "FiraCode" "DroidSansMono" "FiraMono" ]; })
    ];
  };
}
