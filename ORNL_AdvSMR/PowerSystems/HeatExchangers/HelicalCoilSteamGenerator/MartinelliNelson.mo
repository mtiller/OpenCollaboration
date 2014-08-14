within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function MartinelliNelson
  "Calculates Martinelli-Nelson two-phase flow multiplier"

  extends Modelica.Icons.Function;

  /*
  Calculates two-phase flow multiplier using
  Martinelli-Nelson correlation.
  */

  import Modelica.SIunits.*;

protected
  Real Geng "Fluid mass flux";
  AbsolutePressure Peng "Fluid Reynolds number";
  Real aa;
  Real bb;
  Real cc;

public
  input AbsolutePressure P "Pressure";
  input Real G(unit="kg.m/s2") "Secondary side mass flux";

  output Real psi "Martinelli-Nelson multiplier";

  //
  // function psi=GTP(P,G)
  // G is kg/sec/m^2
  // P is in MPa
  //
  // 1 kg/sec/m^2=2.2*3600/3.2808^2 lbm/hr/ft^2=

  //
  // if (Geng<.7)
  //     psi=1.36+.0005*Geng-.000714*Peng*Geng;
  // else
  //     psi=1.26-.0004*Peng+.119/Geng+.00028*Peng/Geng;
  // end
  //

algorithm
  Geng := G*735.809971589708/1.e6;
  Peng := P/6.89476e-3;

end MartinelliNelson;
