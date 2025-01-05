{ ... }: {
  users = {
    users.davethai = {
      isSystemUser = true;
      group = "davethai";
    };
    groups.davethai = {};
  };
}