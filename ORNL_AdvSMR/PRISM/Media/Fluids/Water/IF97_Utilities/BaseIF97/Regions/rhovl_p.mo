within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhovl_p
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input Common.IF97PhaseBoundaryProperties bpro "property record";
  output SI.Density rho "density";
algorithm
  rho := bpro.d;
  annotation (
    derivative(noDerivative=bpro) = rhovl_p_der,
    Inline=false,
    LateInline=true);
end rhovl_p;
