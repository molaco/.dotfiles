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
      theme = "onedark";

      editor = {
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
     
    languages = with pkgs; [
      {
        name = "cpp";
        auto-format = true;
        language-server = {
          command = "${clang-tools}/bin/clangd";
          clangd.fallbackFlags = ["-std=c++2b"];
        };
        formatter = {
          command = "${clang-tools}/bin/clang-format";
          args = ["-i"];
        };
      }
      {
        name = "css";
        auto-format = true;
      }
      {
        name = "go";
        auto-format = true;
        language-server.command = "${gopls}/bin/gopls";
        formatter.command = "${go}/bin/gofmt";
      }
      {
        name = "javascript";
        auto-format = true;
        language-server = {
          command = "${nodePackages.typescript-language-server}/bin/typescript-language-server";
          args = ["--stdio"];
        };
      }
      {
        name = "nix";
        auto-format = true;
        #language-server = {command = lib.getExe inputs.nil.packages.${pkgs.system}.default;};
        config.nil.formatting.command = ["alejandra" "-q"];
      }
      {
        name = "rust";
        auto-format = true;
        formatter.command = lib.getExe rustfmt;
      }
      {
        name = "typescript";
        auto-format = true;
        language-server = {
          command = "${nodePackages.typescript-language-server}/bin/typescript-language-server";
          args = ["--stdio"];
        };
        formatter.command = "${nodePackages.prettier}/bin/prettier";
      }
    ]; 
    };
  }
