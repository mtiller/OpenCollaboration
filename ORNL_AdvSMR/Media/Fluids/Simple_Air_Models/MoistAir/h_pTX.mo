within ORNL_AdvSMR.Media.Fluids.Simple_Air_Models.MoistAir;
function h_pTX
  "Return specific enthalpy of moist air as a function of pressure p, temperature T and composition X"
  extends Modelica.Icons.Function;
  input SI.Pressure p "Pressure";
  input SI.Temperature T "Temperature";
  input SI.MassFraction X[:] "Mass fractions of moist air";
  output SI.SpecificEnthalpy h "Specific enthalpy at p, T, X";
protected
  SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
  SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
  SI.MassFraction X_liquid "mass fraction of liquid water";
  SI.MassFraction X_steam "mass fraction of steam water";
  SI.MassFraction X_air "mass fraction of air";
algorithm
  p_steam_sat := saturationPressure(T);
  //p_steam_sat :=min(saturationPressure(T), 0.999*p);
  X_sat := min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 -
    X[Water]), 1.0);
  X_liquid := max(X[Water] - X_sat, 0.0);
  X_steam := X[Water] - X_liquid;
  X_air := 1 - X[Water];
  /* h        := {SingleGasNasa.h_Tlow(data=steam,  T=T, refChoice=3, h_off=46479.819+2501014.5),
               SingleGasNasa.h_Tlow(data=dryair, T=T, refChoice=3, h_off=25104.684)}*
    {X_steam, X_air} + enthalpyOfLiquid(T)*X_liquid;*/
  h := {SingleGasNasa.h_Tlow(
    data=steam,
    T=T,
    refChoice=3,
    h_off=46479.819 + 2501014.5),SingleGasNasa.h_Tlow(
    data=dryair,
    T=T,
    refChoice=3,
    h_off=25104.684)}*{X_steam,X_air} + enthalpyOfWater(T)*X_liquid;
  annotation (
    derivative=h_pTX_der,
    Inline=false,
    Documentation(info="<html>
Specific enthalpy of moist air is computed from pressure, temperature and composition with X[1] as the total water mass fraction. The fog region is included for both, ice and liquid fog.
</html>"));
end h_pTX;
