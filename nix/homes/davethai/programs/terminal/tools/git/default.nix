{ config, ... }:
let
  sshKey = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
  allowedSigners = "${config.home.homeDirectory}/.config/git/allowed_signers";
in {
  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
      key = sshKey;
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Dave Thai";
        email = "davethai93@gmail.com";
      };
      core.editor = "nvim";
      pull.rebase = true;
      gpg.ssh.allowedSignersFile = allowedSigners;
    };

    includes = [
      {
        condition = "gitdir:~/Documents/dev/arctreon-main/";
        contents = {
          user = {
            name = "Dave Thai";
            email = "dave.thai@arctreon.com";
          };
        };
      }
    ];
  };

  home.file.".config/git/allowed_signers".text = ''
    davethai93@gmail.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlrzGbaqXnERKhTBIaoxLXvuzAI+qt9rgKJxmau9uBr
    dave.thai@arctreon.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlrzGbaqXnERKhTBIaoxLXvuzAI+qt9rgKJxmau9uBr
  '';
}
