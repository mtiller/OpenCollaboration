within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function phase_ps "phase as a function of  pressure and specific entropy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  output Integer phase "true if in liquid or gas or supercritical region";
algorithm
  phase := if ((s < sl_p(p) or s > sv_p(p)) or p > BaseIF97.data.PCRIT)
     then 1 else 2;
  annotation (InlineNoEvent=false);
end phase_ps;
