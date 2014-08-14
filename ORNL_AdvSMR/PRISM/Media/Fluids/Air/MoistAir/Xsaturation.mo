within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function Xsaturation
  "Return absolute humitity per unit mass of moist air at saturation as a function of the thermodynamic state record"
  input ThermodynamicState state "Thermodynamic state record";
  output MassFraction X_sat "Steam mass fraction of sat. boundary";
algorithm
  X_sat := k_mair/(state.p/min(saturationPressure(state.T), 0.999*state.p) - 1
     + k_mair);
  annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of moist air at saturation is computed from pressure and temperature in the state record. Note, that unlike X_sat in the BaseProperties model this mass fraction refers to mass of moist air at saturation.
</html>"));
end Xsaturation;

function xsaturation
  "Return absolute humitity per unit mass of dry air at saturation as a function of the thermodynamic state record"
  input ThermodynamicState state "Thermodynamic state record";
  output MassFraction x_sat "Absolute humidity per unit mass of dry air";
algorithm
  x_sat := k_mair*saturationPressure(state.T)/max(100*Constants.eps, state.p -
    saturationPressure(state.T));
  annotation (smoothOrder=2, Documentation(info="<html>
Absolute humidity per unit mass of dry air at saturation is computed from pressure and temperature in the thermodynamic state record.
</html>"));
end xsaturation;


