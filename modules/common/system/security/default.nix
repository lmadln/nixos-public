{ self, inputs, ... }: {
  flake.nixosSystemModules.security = { config, pkgs, ... }: {

    security = {
      polkit.enable = true;
      rtkit.enable = true;
    };

    sops = {
      defaultSopsFile = ../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";      
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "user_alex_password".neededForUsers = true;
        "user_user_password".neededForUsers = true;
        "user_root_password".neededForUsers = true;
      };
    };

    environment.systemPackages = [ pkgs.sops ];
  };
}
