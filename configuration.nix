# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-uuid/b6888c7a-7e9b-4f38-a394-798cba965c9c";
    preLVM = true;
    allowDiscards = true;  # Enable TRIM support for SSDs
  };
  networking.hostName = "laptop"; # Define your hostname.
  # ntfs support
  boot.supportedFilesystems = [ "ntfs" ];

  # OBS Virtual Camera support
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [
    "v4l2loopback"
  ];
  
  # Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Wireguard
  networking.wg-quick.interfaces.wg0.configFile = "/home/charles/windows-home.conf";
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";
  # Fonts
  fonts = { 
    packages = with pkgs; [
      inter-nerdfont
      fira-code
    ];
    fontconfig = {
    defaultFonts = {
      serif = [  "InterNerdFont" "Serif" ];
      sansSerif = [ "InterNerdFont" "Sans" ]; 
      monospace = [ "FiraCode" "Mono" ];
      };
    };
  };
  
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.charles = {
      isNormalUser = true;
      description = "Charles Mclean";
      extraGroups = [
        "wheel"
	"networkmanager"
        "docker"
      ]; 
      shell = pkgs.zsh;
  };
  
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  
  environment.systemPackages = [
    pkgs.asusctl
    pkgs.sof-firmware
    pkgs.wireplumber
    pkgs.gparted
  ];
  
  # steam
  programs.steam.enable = true;

  # asusd  
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };


  # Hyperland custom
  programs.hyprland.enable = true;
  
  # Mullvad
  services.mullvad-vpn.enable = true;
  
  # VMware commented out in original
  #virtualisation.vmware.host.enable = true;
  #virtualisation.vmware.host.package = (pkgs.vmware-workstation.overrideAttrs rec { 
  #  src = /home/charles/Downloads/VMware-Workstation-Full-17.6.3-24583834.x86_64.bundle;
  #  unpackPhase = let
  #    vmware-unpack-env = pkgs.buildFHSEnv rec {
  #      name = "vmware-unpack-env";
  #      targetPkgs = pkgs: [ pkgs.zlib ];
  #    };
  #  in ''
  #    ${vmware-unpack-env}/bin/vmware-unpack-env -c "sh ${src} --extract unpacked"
  #    # If you need it, copy the enableMacOSGuests stuff here as well.
  #  '';
  #});
  
  # Virt-manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["charles"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  
  # Nautilus
  services.gvfs.enable = true;
  
  # Zsh enable
  programs.zsh.enable = true;
  
  # Dark mode qt
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
   
  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.11"; # Did you read the comment?
}
