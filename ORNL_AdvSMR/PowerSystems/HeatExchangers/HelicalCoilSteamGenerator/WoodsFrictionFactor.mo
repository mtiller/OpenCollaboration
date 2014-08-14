within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function WoodsFrictionFactor
  "Calculates friction factor using Woods correlation"

  extends Modelica.Icons.Function;

  /*
  Wood's fit to Moody friction factor data.
  eetube is roughness (1.e-6 for smooth tube)
  */

  import Modelica.SIunits.*;

protected
  DynamicViscosity mu "Fluid dynamic viscosity";
  ReynoldsNumber Re "Fluid Reynolds number";
  Real aa;
  Real bb;
  Real cc;

public
  input Real Gsec(unit="kg.m/s2") "Secondary side mass flux";
  input Length Dh "Hydraulic diameter for channel";
  input SpecificEnthalpy h "Specific enthalpy of the fluid";
  input AbsolutePressure P "Pressure";

  output CoefficientOfFriction f "Moody's friction coefficient";

algorithm
  //   mu := XSteam(
  //     'my_ph',
  //     P*10,
  //     h);
  Re := Gsec*Dh/mu;

  // ee=.5e-5;
  //
  // aa = 0.94*eetube^0.225 + 0.53*eetube;
  // bb = 88.0*eetube^0.94;
  // cc = 1.62*eetube^0.134;
  // ffricTP = aa + bb/Ref^cc;
  // ffric = 0.0603135909975455 + 0.000915196764790727/Ref^0.315629069598961;

  aa := 0.0603135909975455;
  bb := 0.000915196764790727;
  cc := 0.315629069598961;
  f := aa + bb/Re^cc;

end WoodsFrictionFactor;
