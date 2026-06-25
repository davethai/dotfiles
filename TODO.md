# TODO

- [ ] Move `infisical` to mise via `ubi:Infisical/infisical`; drop the
      `infisical/get-cli` tap + `brew "infisical"` from the Brewfile and the
      brew-script trust loop.
- [ ] Move `kubectl-argo-rollouts` to mise via `ubi:argoproj/argo-rollouts`;
      drop the `argoproj/tap` + `brew "kubectl-argo-rollouts"` likewise.
      (Verify the binary name resolves — may need a ubi `exe:` hint.)
