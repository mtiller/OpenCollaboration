within ORNL_AdvSMR.Functions;
function one
  extends Modelica.Icons.Function;
  input Real x;
  output Real y;
algorithm
  y := 1;
  annotation (derivative=Functions.one_der);
end one;
