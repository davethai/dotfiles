{user, lib, ...}: {
    home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = lib.attrsets.genAttrs ./${user}/home.nix;
  };
}
