{
  buildPythonPackage,
  lib,
  # propagatedBuildInputs
  hypothesis,
  torch,
  # optional-dependencies.lint
  black,
  flake8,
  isort,
  # optional-dependencies.typecheck
  pyright,
  mypy,
}:
buildPythonPackage {
  pname = "hypothesis_torch_utils";
  version = "0.1.0";
  format = "pyproject";

  src = ../.;

  propagatedBuildInputs = [
    hypothesis
    torch
  ];

  doCheck = false;

  passthru.optional-dependencies = {
    lint = [
      black
      flake8
      isort
    ];
    typecheck = [pyright mypy];
  };

  pythonImportsCheck = ["hypothesis_torch_utils"];

  meta = with lib; {
    description = "Utilities for generating PyTorch data with Hypothesis";
    homepage = "https://github.com/ConnorBaker/hypothesis_torch_utils";
    license = licenses.asl20;
    maintainers = with maintainers; [connorbaker];
  };
}
