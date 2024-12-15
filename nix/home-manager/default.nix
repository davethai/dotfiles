{user, ...}: {
    home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = ./${user}/home.nix;
  };
}