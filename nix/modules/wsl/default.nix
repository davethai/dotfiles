{ ... }: {
  imports = [
    ./users
  ];

  system.stateVersion = "24.05";
  wsl = {
    enable = true;
    defaultUser = "davethai";
  };
}