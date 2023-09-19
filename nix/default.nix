{inputs, ...}: {
  imports = [
    ./devShells
    ./packages
  ];
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = with (import ./overlays); [
        flake.overlays.default
      ];
    };
  };
}
