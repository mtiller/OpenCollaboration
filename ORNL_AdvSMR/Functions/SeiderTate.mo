within ORNL_AdvSMR.Functions;
function SeiderTate "Seider-Tate Nusselt number correlation"

  /*
  Seider-Tate Nusselt number for low Re internal flow at constant surface temperature.
  Represents average channel HTC including entrace region.
  Incropera & DeWitt p. 460
   */

  extends Modelica.Icons.Function;

  input Real Re "Reynolds number";
  input Real Pr "Prandtl number";
  input Real LoverD "Channel length-to-hydraulic diameter ratio";
  input Real muOvermus
    "Ratio of viscosity at average temperature to viscosity at surface temperature";
  output Real Nu "Nusselt number";

algorithm
  Nu := 1.86*(Re*Pr/LoverD)^(1/3)*muOvermus^0.14;

end SeiderTate;
