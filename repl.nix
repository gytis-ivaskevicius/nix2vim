let
  flake = builtins.getFlake (toString ./.);
in
{
  dsl = flake.outputs.lib.dsl;
}
