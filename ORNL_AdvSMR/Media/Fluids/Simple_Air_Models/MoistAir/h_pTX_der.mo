within ORNL_AdvSMR.Media.Fluids.Simple_Air_Models.MoistAir;
function h_pTX_der "Derivative function of h_pTX"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.Temperature T "Temperature";
  input SI.MassFraction X[:] "Mass fractions of moist air";
  input Real dp(unit="Pa/s") "Pressure derivative";
  input Real dT(unit="K/s") "Temperature derivative";
  input Real dX[:](each unit="1/s") "Composition derivative";
  output Real h_der(unit="J/(kg.s)") "Time derivative of specific enthalpy";
protected
  SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
  SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
  SI.MassFraction X_liquid "Mass fraction of liquid water";
  SI.MassFraction X_steam "Mass fraction of steam water";
  SI.MassFraction X_air "Mass fraction of air";
  SI.MassFraction x_sat
    "Absolute humidity per unit mass of dry air at saturation";
  Real dX_steam(unit="1/s") "Time deriveative of steam mass fraction";
  Real dX_air(unit="1/s") "Time derivative of dry air mass fraction";
  Real dX_liq(unit="1/s") "Time derivative of liquid/solid water mass fraction";
  Real dps(unit="Pa/s") "Time derivative of saturation pressure";
  Real dx_sat(unit="1/s")
    "Time derivative of abolute humidity per unit mass of dry air";
algorithm
  p_steam_sat := saturationPressure(T);
  x_sat := p_steam_sat*k_mair/max(100*Modelica.Constants.eps, p - p_steam_sat);
  X_sat := min(x_sat*(1 - X[Water]), 1.0);
  X_liquid := Utilities.spliceFunction(
    X[Water] - X_sat,
    0.0,
    X[Water] - X_sat,
    1e-6);
  X_steam := X[Water] - X_liquid;
  X_air := 1 - X[Water];

  dX_air := -dX[Water];
  dps := saturationPressure_der(Tsat=T, dTsat=dT);
  dx_sat := k_mair*(dps*(p - p_steam_sat) - p_steam_sat*(dp - dps))/(p -
    p_steam_sat)/(p - p_steam_sat);
  dX_liq := Utilities.spliceFunction_der(
    X[Water] - X_sat,
    0.0,
    X[Water] - X_sat,
    1e-6,
    (1 + x_sat)*dX[Water] - (1 - X[Water])*dx_sat,
    0.0,
    (1 + x_sat)*dX[Water] - (1 - X[Water])*dx_sat,
    0.0);
  //dX_liq:=if X[Water]>=X_sat then (1+x_sat)*dX[Water]-(1-X[Water])*dx_sat else 0;
  dX_steam := dX[Water] - dX_liq;

  h_der := X_steam*IdealGases.Common.SingleGasNasa.h_Tlow_der(
    data=steam,
    T=T,
    refChoice=3,
    h_off=46479.819 + 2501014.5,
    dT=dT) + dX_steam*IdealGases.Common.SingleGasNasa.h_Tlow(
    data=steam,
    T=T,
    refChoice=3,
    h_off=46479.819 + 2501014.5) + X_air*
    IdealGases.Common.SingleGasNasa.h_Tlow_der(
    data=dryair,
    T=T,
    refChoice=3,
    h_off=25104.684,
    dT=dT) + dX_air*IdealGases.Common.SingleGasNasa.h_Tlow(
    data=dryair,
    T=T,
    refChoice=3,
    h_off=25104.684) + X_liquid*enthalpyOfWater_der(T=T, dT=dT) + dX_liq*
    enthalpyOfWater(T);

  annotation (
    Inline=false,
    smoothOrder=1,
    Documentation(info="<html>
Derivative function for <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
end h_pTX_der;
