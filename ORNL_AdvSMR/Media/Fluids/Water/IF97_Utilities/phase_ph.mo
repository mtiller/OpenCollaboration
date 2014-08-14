within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function phase_ph "phase as a function of  pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output Integer phase "true if in liquid or gas or supercritical region";
algorithm
  phase := if ((h < hl_p(p) or h > hv_p(p)) or p > BaseIF97.data.PCRIT) then 1
     else 2;
  annotation (InlineNoEvent=false);
end phase_ph;
