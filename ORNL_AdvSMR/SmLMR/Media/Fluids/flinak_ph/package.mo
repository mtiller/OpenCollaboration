within ORNL_AdvSMR.SmLMR.Media.Fluids;
package flinak_ph "Flinak (explicit in p and h)"
extends flinak_base(
  ThermoStates=Choices.IndependentVariables.ph,
  final ph_explicit=true,
  final dT_explicit=false,
  final pT_explicit=false,
  smoothModel=false,
  onePhase=true);


annotation (Documentation(info="<html>

</html>"));
end flinak_ph;
