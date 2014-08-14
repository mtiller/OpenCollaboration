within ORNL_AdvSMR.SmLMR.Media.Fluids;
package flibe_ph "Flibe (explicit in p and h)"
extends flibe_base(
  ThermoStates=Choices.IndependentVariables.ph,
  final ph_explicit=true,
  final dT_explicit=false,
  final pT_explicit=false,
  smoothModel=false,
  onePhase=false);


annotation (Documentation(info="<html>

</html>"));
end flibe_ph;
