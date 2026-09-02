{ myHostname, ... }: {
  home.file.".ssh/config".text = ''
    Host astore.rdp
      Hostname 51.83.161.40
      Port 48885
    Host astore.ssh
      Hostname 51.83.161.40
      Port 52599
  '';
}