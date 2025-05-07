# Home configuration for charles
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    mesa
    home-manager
    hyprland
    hypridle
    hyprlock 
    hyprpaper
    hyprshot
    htop
    kitty
    neovim
    waybar
    veracrypt
    vscodium    
    firefox
    chromium
    gnome-calculator
    brightnessctl
    wofi
    tree
    remmina
    mullvad-vpn
    libreoffice-still
    gimp
    mpv
    tor-browser-bundle-bin
    spotify
    pavucontrol
    alsa-utils
    virt-viewer
    nautilus
    p7zip
    gnome-themes-extra
    networkmanagerapplet
    neofetch
    obs-studio
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
  home.file = {
    ".config/waybar/".source = ./waybar; 
    ".config/hypr/".source = ./hypr;
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
