within ORNL_AdvSMR.Media.Fluids.Simple_Air_Models.MoistAir;
function relativeHumidity
  "Return relative humidity as a function of the thermodynamic state record"
  input ThermodynamicState state "Thermodynamic state";
  output Real phi "Relative humidity";
algorithm
  phi := relativeHumidity_pTX(
    state.p,
    state.T,
    state.X);
  annotation (smoothOrder=2, Documentation(info="<html>
Relative humidity is computed from the thermodynamic state record with 1.0 as the upper limit at saturation.
</html>"));
end relativeHumidity;
