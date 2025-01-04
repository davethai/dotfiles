_: {
  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    users.davethai = import ./davethai/home.nix;
  };
}