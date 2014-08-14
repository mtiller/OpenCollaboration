within ORNL_AdvSMR.Functions;
function linear
  extends Modelica.Icons.Function;
  input Real x;
  output Real y;
algorithm
  y := x;
  annotation (derivative=Functions.linear_der);
end linear;
