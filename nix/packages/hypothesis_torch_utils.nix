{
  buildPythonPackage,
  lib,
  # propagatedBuildInputs
  torch,
  hypothesis,
  # optional-dependencies.dev
  black,
  ruff,
  pyright,
  mypy,
}: let
  attrs = {
    pname = "hypothesis_torch_utils";
    version = "0.1.0";
    format = "flit";

    src = lib.sources.sourceByRegex ../.. [
      "${attrs.pname}(:?/.*)?"
      "pyproject.toml"
    ];

    doCheck = false;

    propagatedBuildInputs = [hypothesis torch];

    passthru.optional-dependencies.dev = [
      # Linters/formatters
      black
      ruff
      # Type checkers
      pyright
      mypy
    ];

    pythonImportsCheck = [attrs.pname];

    meta = with lib; {
      description = "Utilities for generating PyTorch data with Hypothesis";
      homepage = "https://github.com/ConnorBaker/hypothesis_torch_utils";
      license = licenses.asl20;
      maintainers = with maintainers; [connorbaker];
    };
  };
in
  buildPythonPackage attrs
