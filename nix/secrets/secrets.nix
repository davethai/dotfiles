let
  davethai = "";
  users = [ davethai ];
in {
  "secret1.age".publicKeys = [ davethai ];
  "secret2.age".publicKeys = users;
}