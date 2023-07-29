{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    settings = {
    # Download theme from helix/runtime github via home-manager
      theme = "onedark";
      keys.normal = {
        "C-up" = "scroll_up";
        "C-down" = "scroll_down";
      };
      
      editor = {
        mouse = false;
        line-number = "relative";
        true-color = true;
        cursor-shape = {
          insert = "bar";
        };
        statusline = {
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
            };
          };
        };

      };
     
    # languages = {};
  };
}
