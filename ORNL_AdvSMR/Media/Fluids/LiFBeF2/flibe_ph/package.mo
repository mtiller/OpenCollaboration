within ORNL_AdvSMR.Media.Fluids.LiFBeF2;
package flibe_ph "Flibe (explicit in p and h)"
extends LiFBeF2.flibe_base(
  ThermoStates=Choices.IndependentVariables.ph,
  final ph_explicit=true,
  final dT_explicit=false,
  final pT_explicit=false,
  smoothModel=true,
  onePhase=true);


annotation (Documentation(info="<html>

</html>"));
end flibe_ph;
