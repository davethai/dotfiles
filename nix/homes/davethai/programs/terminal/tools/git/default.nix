
{
  programs.git = {
    enable = true;
    userName = "davethai";
    userEmail = "dave@davethai.com";
    extraConfig = {
      core.editor = "nvim";
      pull.rebase = true;
    };
  };
}