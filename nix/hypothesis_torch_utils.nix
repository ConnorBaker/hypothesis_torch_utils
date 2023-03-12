{
  pkgs,
  stdenv,
  lib,
  autoPatchelfHook,
  python,
  fetchFromGitHub,
  buildPythonPackage,
  # Propagated build inputs
  torch,
  hypothesis,
  black,
  flake8,
  isort,
  pyright,
  mypy,
}:
buildPythonPackage {
  pname = "hypothesis_torch_utils";
  version = "0.1.0";
  format = "pyproject";

  src = ../.;

  propagatedBuildInputs = [
    torch
    hypothesis
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
}
