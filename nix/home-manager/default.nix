{user, ...}: {
    home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {
      home = ./${user}/home.nix;
    };
  };
}
