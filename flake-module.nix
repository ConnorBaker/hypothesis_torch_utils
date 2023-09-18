{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.hypothesis_torch_utils = pkgs.mkShell {
      inputsFrom = [config.packages.hypothesis_torch_utils];
      packages = with config.packages.hypothesis_torch_utils.optional-dependencies; [lint typecheck];
    };
    packages.hypothesis_torch_utils = let
      inherit (pkgs) lib python3Packages;
      attrs = {
        pname = "hypothesis_torch_utils";
        version = "0.1.0";
        format = "flit";

        src = lib.sources.sourceByRegex ./. [
          "${attrs.pname}(:?/.*)?"
          "pyproject.toml"
        ];

        doCheck = false;

        propagatedBuildInputs = with python3Packages; [hypothesis torch];

        passthru.optional-dependencies = {
          lint = [python3Packages.black pkgs.ruff];
          typecheck = [pkgs.pyright python3Packages.mypy];
        };

        pythonImportsCheck = ["hypothesis_torch_utils"];

        meta = with lib; {
          description = "Utilities for generating PyTorch data with Hypothesis";
          homepage = "https://github.com/ConnorBaker/hypothesis_torch_utils";
          license = licenses.asl20;
          maintainers = with maintainers; [connorbaker];
        };
      };
    in
      python3Packages.buildPythonPackage attrs;
  };
}
