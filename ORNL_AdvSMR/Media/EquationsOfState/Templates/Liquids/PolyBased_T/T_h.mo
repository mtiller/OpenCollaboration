within ORNL_AdvSMR.Media.EquationsOfState.Templates.Liquids.PolyBased_T;
function T_h "Pressure independant temperature function"
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  output Units.Temperature T "Temperature";
algorithm
  assert(analyticInverseTfromh,
    "T_phX: No analytic inverse for polynomials with npol_Cp > 1");
  T := if data.npol_Cp == 0 then T0 + (h - data.reference_h)/data.polyHeatCapacity[
    1] elseif data.npol_Cp == 1 then sqrt(max(1e-6, (data.polyHeatCapacity[2]/
    data.polyHeatCapacity[1])^2 + 2/data.polyHeatCapacity[1]*(data.polyHeatCapacity[
    2]*T0 + h - data.reference_h) + T0^2)) - data.polyHeatCapacity[2]/data.polyHeatCapacity[
    1] else Modelon.Math.Polynomials.oneRealRootOfCubic({data.polyHeatCapacity[
    1]/3,data.polyHeatCapacity[2]/2,data.polyHeatCapacity[3],data.reference_h
     - h - data.polyHeatCapacity[1]/3*T0*T0*T0 - data.polyHeatCapacity[2]/2*T0*
    T0 - data.polyHeatCapacity[3]*T0});
end T_h;
