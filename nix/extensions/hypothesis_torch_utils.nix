final: prev: {
  python3Packages = prev.python3Packages.overrideScope (python-final: python-prev: {
    hypothesis_torch_utils = python-final.callPackage ../hypothesis_torch_utils.nix {};
  });
}
