{ pkgMap, ... }: {
  programs.vscode = {
    enable        = true;
    package       = pkgMap.vscode-fhs;
  };
  programs.vscodium = {
    enable        = true;
    package       = pkgMap.vscodium-fhs;
  };
}
