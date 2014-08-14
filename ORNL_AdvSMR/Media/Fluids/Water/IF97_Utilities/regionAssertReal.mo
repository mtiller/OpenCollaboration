within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function regionAssertReal "assert function for inlining"
  extends Modelica.Icons.Function;
  input Boolean check "condition to check";
  output Real dummy "dummy output";
algorithm
  assert(check, "this function can not be called with two-phase inputs!");
end regionAssertReal;
