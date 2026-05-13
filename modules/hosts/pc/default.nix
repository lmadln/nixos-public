{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.sops-nix.nixosModules.sops
      self.nixosModules.pcHardware
      self.nixosModules.pcConfiguration
    ];
  };
}
