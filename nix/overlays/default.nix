{
  flake.overlays.default = _: prev: {
    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (
          pythonFinal: _: {
            hypothesis_torch_utils = pythonFinal.callPackage ../packages/hypothesis_torch_utils.nix {};
          }
        )
      ];
  };
}
