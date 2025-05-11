{pkgs, lib, ...}: let
  inherit (lib.meta) getExe;
  inherit (pkgs) bat eza;
in {
  programs.zsh.shellAliases = {
    # make sudo use aliases
    sudo = "sudo ";

    # quality of life aliases
    cat = "${getExe bat} --style=plain";
    ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
    c = "clear";

    # git
    gst = "git status";
    gaa = "git add .";
    gc = "git commit";
    gp = "git push";

    # k8s
    k = "kubectl";
    # Get
    kga = "kubectl get all";
    kgans = "kubectl get all --all-namespaces";
    kgp = "kubectl get pods";
    kgsvc = "kubectl get services";
    kgep = "kubectl get endpoints";
    kgns = "kubectl get namespaces";
    kgno = "kubectl get nodes";
    kgpv = "kubectl get persistentvolumes";
    kgpvc = "kubectl get persistentvolumeclaims";
    kgcm = "kubectl get configmaps";
    kgs = "kubectl get secrets";
    kgs = "kubectl get secrets";
    kgev = "kubectl get events";
    kgsa = "kubectl get serviceaccounts";
    kgd = "kubectl get deploy";
    kgrs = "kubectl get replicasets";
    kgsts = "kubectl get statefulsets";
    kgds = "kubectl get daemonsets";
    kgj = "kubectl get jobs";
    kgcj = "kubectl get cronjobs";
    kging = "kubectl get ingresses";
    kging = "kubectl get ingresses";
    kgnetpol = "kubectl get networkpolicies";

    # quick navigation
    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";
    "......" = "cd ../../../../../";
  };
}