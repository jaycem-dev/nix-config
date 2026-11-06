{ pkgs, ... }:
let
  wakeTime = "10:00";
in
{
  systemd.services.arm-rtc-wakealarm = {
    description = "Arm RTC wake alarm for ${wakeTime}";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    path = [ pkgs.util-linux ]; # for rtcwake; date comes from systemd.defaultPath

    serviceConfig.Type = "oneshot";
    script = ''
      target=$(date -d "today ${wakeTime}" +%s)
      if [ "$target" -le "$(date +%s)" ]; then
        target=$(date -d "tomorrow ${wakeTime}" +%s)
      fi

      echo 0 > /sys/class/rtc/rtc0/wakealarm || true
      rtcwake -m no -t "$target"
      echo "RTC wake alarm set for $(date -d "@$target")"
    '';
  };
}
