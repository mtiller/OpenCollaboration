within ORNL_AdvSMR.SmLMR.Media.Fluids.Air.MoistAir;
function massFraction_pTphi
  "Return steam mass fraction as a function of relative humidity phi and temperature T"
  input AbsolutePressure p "Pressure";
  input Temperature T "Temperature";
  input Real phi "Relative humidity (0 ... 1.0)";
  output MassFraction X_steam "Absolute humidity, steam mass fraction";
protected
  constant Real k=0.621964713077499 "Ratio of molar masses";
  AbsolutePressure psat=saturationPressure(T) "Saturation pressure";
algorithm
  X_steam := phi*k/(k*phi + p/psat - phi);
  annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of moist air is computed from temperature, pressure and relative humidity.
</html>"));
end massFraction_pTphi;
