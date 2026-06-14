{ config, pkgs, lib, system, ... }:{
  imports = [
    ./packages
    ./programs
  ];

  home = {
    stateVersion = "23.05";
    username = "davethai";

    sessionVariables = {
      JAVA_HOME = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home";
    };
  };
}