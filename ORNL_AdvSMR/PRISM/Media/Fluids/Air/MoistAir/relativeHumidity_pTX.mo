within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function relativeHumidity_pTX
  "Return relative humidity as a function of pressure p, temperature T and composition X"
  input SI.Pressure p "Pressure";
  input SI.Temperature T "Temperature";
  input SI.MassFraction[:] X "Composition";
  output Real phi "Relative humidity";
protected
  SI.Pressure p_steam_sat "Saturation pressure";
  SI.MassFraction X_air "Dry air mass fraction";
algorithm
  p_steam_sat := min(saturationPressure(T), 0.999*p);
  X_air := 1 - X[Water];
  phi := max(0.0, min(1.0, p/p_steam_sat*X[Water]/(X[Water] + k_mair*X_air)));
  annotation (smoothOrder=2, Documentation(info="<html>
Relative humidity is computed from pressure, temperature and composition with 1.0 as the upper limit at saturation. Water mass fraction is the first entry in the composition vector.
</html>"));
end relativeHumidity_pTX;
