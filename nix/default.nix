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
  version = "1.7";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ConnorBaker";
    repo = "hypothesis_torch_utils";
    rev = "6a148268ee3f384c67f2f3cd15333e2b836c715b";
    hash = "sha256-dPjgSeMGCIXgMO4Oulywa55jJOeXkgBpeqDzl5FG4Dw=";
  };

  propagatedBuildInputs = [
    torch
    hypothesis
  ];

  # NOTE: We cannot use pythonImportsCheck for this module because it requires CUDA to be
  #   available at the time of import.
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
