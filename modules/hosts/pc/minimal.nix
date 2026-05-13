{ self, inputs, ... }: {
  flake.nixosConfigurations.pcMinimal = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # inputs.sops-nix.nixosModules.sops
      self.nixosModules.pcHardware
      # self.nixosModules.pcConfiguration
      self.nixosModules.pcMinimalConfiguration
    ];
  };
}
