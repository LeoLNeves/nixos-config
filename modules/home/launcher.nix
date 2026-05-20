{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wofi
  ];

  xdg.configFile."wofi/config".text = ''
    show=drun
    prompt=Search apps
    allow_images=true
    allow_markup=true
    insensitive=true
    width=420
    height=360
    layer=overlay
    location=center
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
      margin: 0px;
      border: 1px solid rgba(255, 255, 255, 0.08);
      border-radius: 20px;
      background-color: rgba(18, 18, 22, 0.98);
      color: #f4f4f5;
      font-family: "JetBrainsMono Nerd Font";
      font-size: 14px;
    }

    #outer-box {
      padding: 14px;
    }

    #input {
      margin: 0 0 12px 0;
      padding: 10px 12px;
      border: 0;
      border-radius: 14px;
      color: #f4f4f5;
      background-color: rgba(255, 255, 255, 0.06);
    }

    #input:focus {
      outline: none;
      box-shadow: none;
    }

    #scroll {
      margin: 0;
    }

    #entry {
      padding: 10px 12px;
      border-radius: 14px;
      background: transparent;
    }

    #entry:selected {
      background-color: rgba(255, 255, 255, 0.08);
    }

    #img {
      margin-right: 10px;
    }

    #text {
      color: #f4f4f5;
    }
  '';
}