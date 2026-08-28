{ pkgMap, pkgs, ... }: {
  programs.vscodium = {
    enable  = true;
    package = pkgMap.vscodium-fhs;
    mutableExtensionsDir = true;
    profiles.default  = {
      extensions = with pkgs.vscode-extensions; [
        ms-vscode.cpptools
        naumovs.color-highlight
        donjayamanne.githistory
        github.vscode-pull-request-github
        codezombiech.gitignore
        ms-vscode.hexeditor
        yzhang.markdown-all-in-one
        yzane.markdown-pdf
        pkief.material-icon-theme
        bbenoist.nix
        jnoortheen.nix-ide
        ms-python.vscode-pylance
        ms-python.python
        ms-python.debugpy
        ms-python.vscode-python-envs
        mechatroner.rainbow-csv
        svelte.svelte-vscode
        tomoki1207.pdf
        # --- packages below this line do not exist in nixpkgs ----
        # jeff-hykin.better-shellscript-syntax
        # mrmlnc.vscode-json5
        # amandeepmittal.pug
        # syler.sass-indented
        # sysoev.language-stylus
        # fms-cat.xml-stepmania
      ];
      userSettings = {
        # Theme/UI settings
        "workbench.colorTheme"  = "Ceres";
        "workbench.iconTheme"   = "material-icon-theme";

        # Window settings
        "window.commandCenter"  = false;

        # Editor settings
        "editor.fontFamily"         = "'JetBrainsMono Nerd Font'";
        "editor.fontSize"           = 13.5;
        "editor.tabSize"            = 2;
        "editor.fontWeight"         = 400;
        "editor.lineHeight"         = 1.25;
        "editor.letterSpacing"      = -0.5;
        "editor.renderWhitespace"   = "trailing";
        "editor.selectionClipboard" = false;
        "breadcrumbs.enabled"       = false;
        "workbench.browser.showInTitleBar" = false;

        # Terminal settings
        "terminal.integrated.fontSize"        = 14;
        "terminal.integrated.fontWeight"      = 400;
        "terminal.integrated.fontWeightBold"  = 900;
        "terminal.integrated.lineHeight"      = -1;

        # Git settings
        "git.enableSmartCommit" = true;
        "git.confirmSync"       = false;

        # Language settings
        "svelte.enable-ts-plugin"           = true;

        # Misc.
        "security.workspace.trust.enabled"  = false;
      };
    };
  };
}
