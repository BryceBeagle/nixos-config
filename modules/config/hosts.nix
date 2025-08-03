# This config comes straight from the `denix` docs with no changes.
#
# https://yunfachi.github.io/denix/hosts/examples#minimally-recommended
#
# This is the recommended config for the (required) `host` config option
{delib, ...}:
delib.module {
  name = "hosts";

  options = with delib; let
    host = {
      options =
        hostSubmoduleOptions
        // {
        };
    };
  in {
    host = hostOption host;
    hosts = hostsOption host;
  };

  home.always = {myconfig, ...}: {
    assertions = delib.hostNamesAssertions myconfig.hosts;
  };
}
