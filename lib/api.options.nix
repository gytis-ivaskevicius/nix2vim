{ lib, ... }:

with lib; {
  options = {
    vim = mkOption {
      default = { };
      type = types.attrs;
    };
  };
}
