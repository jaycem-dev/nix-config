{ pkgs, ... }:
let
  wakeTime = "10:00";
  suspendTime = "02:00";
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

  systemd.services.auto-suspend = {
    description = "Automatic suspend at ${suspendTime}";
    path = [ pkgs.systemd ];

    serviceConfig.Type = "oneshot";
    script = "systemctl suspend";
  };

  systemd.timers.auto-suspend = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = suspendTime;
      Persistent = false; # don't suspend right after boot if 2am was missed
    };
  };
}
