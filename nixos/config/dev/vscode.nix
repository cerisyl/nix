{ pkgMap, ... }: {
  programs.vscode = {
    enable        = true;
    package       = pkgMap.vscode-fhs;
  };
}
