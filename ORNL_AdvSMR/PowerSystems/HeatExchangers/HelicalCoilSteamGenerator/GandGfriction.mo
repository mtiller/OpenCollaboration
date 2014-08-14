within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function GandGfriction

  /*
  Seider-Tate Nusselt number for low Re internal flow at constant surface temperature.
  Represents average channel HTC including entrace region.
  Incropera & DeWitt p. 460

   extends Modelica.Icons.Function;

   input Real Re "Reynolds number";
   input Real Pr "Prandtl number";
   input Real LoverD "Channel length-to-hydraulic diameter ratio";
   input Real muOvermus 
    "Ratio of viscosity at average temperature to viscosity at surface temperature";
   output Real Nu "Nusselt number";

algorithm 
  Nu := 1.86 * (Re*Pr / LoverD)^(1/3) * muOvermus^0.14;
  */

  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;

  input Real Xl "SL/D";
  input Real Xt "ST/D";
  input Real ReD "Reynolds number u_max D / nu";
  output Real HgLam "Hagen number for laminar flow";
  // output Real HgTur "Hagen number for turbulent flow";

algorithm
  HgLam := 140*ReD*((Xl^0.5 - 0.6)^2 + 0.75)/(Xt^1.6*((4*Xt*Xl)/(pi - 1)));

end GandGfriction;
