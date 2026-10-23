{
  networking = {
    wireless.iwd.enable = true;
    nameservers = [
      "127.0.0.1"
      "::1"
    ];

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      dns = "none"; # we are using dnsproxy for the dns
    };

    firewall = {
      enable = true;
      trustedInterfaces = [ "virbr0" ]; # libvirt network
    };
  };
}
