
{
  programs.git = {
    enable = true;
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