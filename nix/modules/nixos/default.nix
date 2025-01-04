{ ... }: {
  system.stateVersion = "23.05";

  users = {
    groups.davethai = {};
    users.davethai = {
      isNormalUser = true;
      extraGroups = ["davethai"];
      home = "/home/davethai";
      createHome = true;
      # initialPassword = "alpha";
    };
  };
}