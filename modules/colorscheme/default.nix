{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.colorscheme;
in {
  options.vim.colorscheme = {
    set = mkOption {
      type = types.enum ["catppuccin" "tokyonight" "oceanicnext" "srcery"];
      default = "srcery";
      description = "Choose colorscheme";
    };
    transparent = mkOption {
      type = types.bool;
      default = true;
      description = "Toggle transparent background";
    };
  };
  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [srcery catppuccin tokyonight oceanicnext nvim-transparent];

    vim.configRC = ''
      set background=dark
      colorscheme srcery
    '';

    vim.luaConfigRC = ''
      -- Enable transparency plugin
      require('transparent').setup()
      map("n", "<leader>ut", "<cmd>TransparentToggle<cr>", { desc = "Toggle Transparency" })
    '';
  };
}
