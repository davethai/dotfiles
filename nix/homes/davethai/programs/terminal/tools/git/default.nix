
{
  programs.git = {
    enable = true;
    signing.format = "openpgp";
    settings = {
      user = {
        name = "davethai";
        email = "dave@davethai.com";
      };
      core.editor = "nvim";
      pull.rebase = true;
    };
  };
}