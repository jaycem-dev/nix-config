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

    firewall = rec {
      enable = true;
      trustedInterfaces = [ "virbr0" ]; # libvirt network
      allowedTCPPorts = [
        53317 # localsend
        8384 # syncthing gui, FIXME: do i need this?
      ];
      allowedUDPPorts = [
        53317 # localsend
      ];
      # kdeconnect
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
