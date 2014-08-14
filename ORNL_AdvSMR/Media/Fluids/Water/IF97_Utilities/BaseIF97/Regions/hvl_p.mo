within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hvl_p
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input Common.IF97PhaseBoundaryProperties bpro "property record";
  output SI.SpecificEnthalpy h "specific enthalpy";
algorithm
  h := bpro.h;
  annotation (
    derivative(noDerivative=bpro) = hvl_p_der,
    Inline=false,
    LateInline=true);
end hvl_p;
