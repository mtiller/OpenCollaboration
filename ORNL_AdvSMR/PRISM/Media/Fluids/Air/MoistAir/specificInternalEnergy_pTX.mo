within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function specificInternalEnergy_pTX
  "Return specific internal energy of moist air as a function of pressure p, temperature T and composition X"
  input SI.Pressure p "Pressure";
  input SI.Temperature T "Temperature";
  input SI.MassFraction X[:] "Mass fractions of moist air";
  output SI.SpecificInternalEnergy u "Specific internal energy";
protected
  SI.AbsolutePressure p_steam_sat "Partial saturation pressure of steam";
  SI.MassFraction X_liquid "Mass fraction of liquid water";
  SI.MassFraction X_steam "Mass fraction of steam water";
  SI.MassFraction X_air "Mass fraction of air";
  SI.MassFraction X_sat "Absolute humidity per unit mass of moist air";
  Real R_gas "Ideal gas constant";
algorithm
  p_steam_sat := saturationPressure(T);
  X_sat := min(p_steam_sat*k_mair/max(100*Constants.eps, p - p_steam_sat)*(1 -
    X[Water]), 1.0);
  X_liquid := max(X[Water] - X_sat, 0.0);
  X_steam := X[Water] - X_liquid;
  X_air := 1 - X[Water];
  R_gas := dryair.R*X_air/(1 - X_liquid) + steam.R*X_steam/(1 - X_liquid);
  u := X_steam*SingleGasNasa.h_Tlow(
    data=steam,
    T=T,
    refChoice=3,
    h_off=46479.819 + 2501014.5) + X_air*SingleGasNasa.h_Tlow(
    data=dryair,
    T=T,
    refChoice=3,
    h_off=25104.684) + enthalpyOfWater(T)*X_liquid - R_gas*T;

  annotation (derivative=specificInternalEnergy_pTX_der, Documentation(info="<html>
Specific internal energy is determined from pressure p, temperature T and composition X, assuming that the liquid or solid water volume is negligible.
</html>"));
end specificInternalEnergy_pTX;
