{ config, lib, pkgs, myHostname, ... }: let
in {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        verbatimConfig = ''
          seccomp_sandbox = 0
          cgroup_device_acl = [
            "/dev/kvm", "/dev/kvmfr0", "/dev/kvmfr1", "/dev/kvmfr2",
            "/dev/shm/looking-glass",
            "/dev/null", "/dev/full", "/dev/zero", "/dev/random",
            "/dev/urandom", "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc", "/dev/hpet", "/dev/vfio/vfio"
          ]
        '';
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # For looking-glass
  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", KERNEL=="kvmfr0", OWNER="ceri", GROUP="users", MODE="0660"
  '';
}