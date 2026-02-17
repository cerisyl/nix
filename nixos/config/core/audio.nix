{ config, pkgMap, lib, ... }: {
  home.file.".config/pipewire/pipewire.conf.d/pipewire.conf".text = ''
    context.properties = {default.clock.min-quantum = 1024}
  '';
}