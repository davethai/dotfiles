{ ... }: {
  system.stateVersion = "23.05";

  users = {
    groups.davethai = {};
    users.davethai = {
      isSystemUser = true;
      extraGroups = ["davethai"];
      home = "/home/davethai";
      createHome = true;
    };
  };

  wsl.eable = true;
}