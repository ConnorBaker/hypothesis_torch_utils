{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.hypothesis_torch_utils = pkgs.mkShell {
      inputsFrom = [config.packages.hypothesis_torch_utils];
      packages = config.packages.hypothesis_torch_utils.optional-dependencies.dev;
    };
  };
}
