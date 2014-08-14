within ORNL_AdvSMR.Functions;
function Pethukov "Modified Pethukov Nusselt number correlation"

  /*
  Modified Pethukov formula for Nusselt number
  Incropera & DeWitt  (p. 460)
  Valid for 0.5 < Pr < 2000 and 3e3 < Re < 5e6
  */

  extends Modelica.Icons.Function;

  input Real f "Darcy friction factor";
  input Real Re "Reynolds number";
  input Real Pr "Prandtl number";
  output Real Nu "Nusselt numnber";

algorithm
  Nu := (f/8)*(Re - 1000)*Pr/(1 + 12.7*(f/8)^(1/2)*(Pr^(2/3) - 1));

end Pethukov;
