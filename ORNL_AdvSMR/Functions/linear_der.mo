within ORNL_AdvSMR.Functions;
function linear_der
  extends Modelica.Icons.Function;
  input Real x;
  input Real der_x;
  output Real der_y;
algorithm
  der_y := der_x;
end linear_der;
