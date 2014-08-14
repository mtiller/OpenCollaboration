within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function gasConstant_X
  "Return ideal gas constant as a function from composition X"
  input SI.MassFraction X[:] "Gas phase composition";
  output SI.SpecificHeatCapacity R "Ideal gas constant";
algorithm
  R := dryair.R*(1 - X[Water]) + steam.R*X[Water];
  annotation (smoothOrder=2, Documentation(info="<html>
The ideal gas constant for moist air is computed from the gas phase composition. The first entry in composition vector X is the steam mass fraction of the gas phase.
</html>"));
end gasConstant_X;
