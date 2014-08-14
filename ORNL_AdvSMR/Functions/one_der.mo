within ORNL_AdvSMR.Functions;
function one_der
  extends Modelica.Icons.Function;
  input Real x;
  input Real der_x;
  output Real der_y;
algorithm
  der_y := 0;
end one_der;
