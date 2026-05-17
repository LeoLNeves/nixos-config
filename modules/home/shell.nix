{ ... }:

{
  programs.bash = {
    enable = true;
    
    # This enables Starship to hook into Bash automatically
    enableCompletion = true; 
    
    # Anything in here gets injected into your ~/.bashrc
    # It runs every time you open a new terminal
    initExtra = ''
      fastfetch
    '';
  };
}
