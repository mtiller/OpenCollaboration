within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function phase_dT "phase as a function of  pressure and temperature"
  extends Modelica.Icons.Function;
  input SI.Density rho "density";
  input SI.Temperature T "temperature";
  output Integer phase "true if in liquid or gas or supercritical region";
algorithm
  phase := if not ((rho < rhol_T(T) and rho > rhov_T(T)) and T < BaseIF97.data.TCRIT)
     then 1 else 2;
  annotation (InlineNoEvent=false);
end phase_dT;
