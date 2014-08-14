within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
record IterationData "constants for iterations internal to some functions"

  extends Modelica.Icons.Record;
  constant Integer IMAX=50 "maximum number of iterations for inverse functions";
  constant Real DELP=1.0e-6 "maximum iteration error in pressure, Pa";
  constant Real DELS=1.0e-8
    "maximum iteration error in specific entropy, J/{kg.K}";
  constant Real DELH=1.0e-8
    "maximum iteration error in specific entthalpy, J/kg";
  constant Real DELD=1.0e-8 "maximum iteration error in density, kg/m^3";
end IterationData;
