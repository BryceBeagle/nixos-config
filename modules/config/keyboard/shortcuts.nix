{
  delib,
  lib,
  ...
}:
delib.module {
  name = "keyboard";

  darwin.always.system.defaults.CustomUserPreferences = {
    # https://stackoverflow.com/questions/21878482/what-do-the-parameter-values-in-applesymbolichotkeys-plist-dict-represent
    # https://web.archive.org/web/20141112224103/http://hintsforums.macworld.com/showthread.php?t=114785
    #
    # Can be queried with `defaults read com.apple.symbolichotkeys`
    #
    # Changing these typically requires logging in/out to see the effects, but can be
    # force-reloaded with:
    # /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    #
    # One useful tidbit is that the Keyboard Shortcut UI in the system settings will
    # display a little ⚠ symbol if there is a conflict with another shortcut. If this
    # is the case, the shortcut will fail to do anything at all.
    "com.apple.symbolichotkeys".AppleSymbolicHotKeys = let
      # https://wiki.nixos.org/wiki/Nix_Language_Quirks#Hexadecimal,_octal,_and_binary
      NO_MODIFIER = (builtins.fromTOML "hex = 0x000000").hex;
      SHIFT = (builtins.fromTOML "hex = 0x020000").hex;
      CONTROL = (builtins.fromTOML "hex = 0x040000").hex;
      OPTION = (builtins.fromTOML "hex = 0x080000").hex;
      COMMAND = (builtins.fromTOML "hex = 0x100000").hex;
    in {
      # Always take screenshots to clipboard
      "28".enabled = false; # Save picture of screen as a file
      "30".enabled = false; # Save picture of selected area as a file
      "29" = {
        # Copy picture of screen to clipboard
        enabled = true;
        value = {
          parameters = [
            (lib.strings.charToInt "3")
            20 # https://eastmanreference.com/complete-list-of-applescript-key-codes
            (builtins.bitOr SHIFT COMMAND)
          ];
          type = "standard";
        };
      };
      "31" = {
        # Copy picture of selected area to clipboard
        enabled = true;
        value = {
          parameters = [
            (lib.strings.charToInt "4")
            21 # https://eastmanreference.com/complete-list-of-applescript-key-codes
            (builtins.bitOr SHIFT COMMAND)
          ];
          type = "standard";
        };
      };
    };
  };
}
