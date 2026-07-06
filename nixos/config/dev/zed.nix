{ config, pkgMap, theme, getThemeFile, lib, ... }: {
  programs.zed-editor = {
    enable  = true;
    package = pkgMap.zed-editor;
    extensions = [
      "html"
      "lua"
      "scss"
      "powershell"
      "pug"
      "git-firefly"
      "rainbow-csv"
      "charmed-icons"
    ];
    userSettings = {
      # General settings
      base_keymap = "VSCode";
      auto_update = false;
      disable_ai  = true;
      vim_mode    = false;
      session.trust_all_worktrees = true;

      # Theme/UI settings
      theme = {
        mode  = "dark";
        light = "Ayu Dark";
        dark  = "Ayu Dark";
      };
      icon_theme                = "Light Charmed Icons";
      ui_font_family            = "Barlow";
      ui_font_size              = 14;
      buffer_font_family        = "JetBrainsMono Nerd Font";
      buffer_font_size          = 12.5;
      buffer_font_weight        = 450;
      buffer_line_height.custom = 1.3;

      # Toolbar settings
      toolbar = {
        agent_review    = false;
        breadcrumbs     = false;
        quick_actions   = false;
        selections_menu = false;
      };

      # Tab bar settings
      tab_bar = {
        show_pinned_tabs_in_separate_row = true;
        show_nav_history_buttons = false;
      };

      # Tab behavior
      tabs = {
        file_icons = true;
        git_status = true;
        show_close_button = "always";
      };
      preview_tabs = {
        enabled = true;
        enable_preview_from_project_panel = true;
      };

      # Editor settings
      show_whitespaces      = "trailing";
      allow_rewrap          = "anywhere";
      soft_wrap             = "editor_width";
      inline_code_actions   = false;
      relative_line_numbers = "disabled";
      gutter = {
        runnables   = false;
        breakpoints = false;
        folds       = false;
        min_line_number_digits = 3;
      };
      minimap = {
        show          = "always";
        display_in    = "all_editors";
        thumb         = "hover";
        thumb_border  = "full";
        max_width_columns = 60;
      };

      # Project / filebrowser settings (left)
      project_panel = {
        git_status_indicator = true;
        diagnostic_badges = true;
        entry_spacing = "standard";
        hide_root = true;
        dock = "left";
      };

      # Git panel settings (right)
      git_panel = {
        file_icons = false;
        sort_by_path = true;
      };

      # Status bar settings
      status_bar.line_endings_button  = true;
      diagnostics.button              = false;
      agent.button                    = false;
      collaboration_panel.button      = false;
      outline_pannel.button           = false;

      # Language server settings
      lsp = {
        nix.binary.path_lookup = true;
      };

      # Misc.
      file_types = {
        "Rainbow CSV (|)" = [ "pkgs.csv" ];
      };
      git.inline_blame.enabled  = false;
      cli_default_open_behavior = "new_window";
      bottom_dock_layout        = "right_aligned";
    };
  };
}
