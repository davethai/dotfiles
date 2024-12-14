{user, ...}: {
    home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {
      home = {
        stateVersion = "23.05";
        username = user;
      };
    };
  };
}