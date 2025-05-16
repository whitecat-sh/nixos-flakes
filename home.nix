# Home configuration for charles
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    mesa
    lm_sensors
    home-manager
    hyprland
    nwg-displays
    hypridle
    hyprlock 
    hyprpaper
    hyprshot
    hyprcursor
    htop
    kitty
    neovim
    waybar
    veracrypt
    vscodium    
    mullvad-vpn
    firefox
    chromium
    gnome-calculator
    brightnessctl
    wofi
    tree
    remmina
    libreoffice-still
    gimp
    mpv
    tor-browser-bundle-bin
    spotify
    pavucontrol
    alsa-utils
    virt-viewer
    nautilus
    gnome-themes-extra
    networkmanagerapplet
    neofetch
    obs-studio
    nwg-look
    nmap
    wireshark
    kdePackages.kdenlive
    #ciscoPacketTracer8
    go
    hugo
    moonlight-qt
    numix-cursor-theme
  ];

  # Oh my Zsh
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "gnzh";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  systemd.user.sessionVariables = config.home.sessionVariables;
   
  home.username = "charles"; 
  home.homeDirectory = "/home/charles";
  
  # Configuration files
  # home.file = {
  #  ".config/waybar/".source = ./waybar; 
  #  ".config/hypr/".source = ./hypr;
  #};

  home.pointerCursor = {
  #  gtk.enable = true;
    x11.enable = true;
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor-Light";
  };
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";
}
