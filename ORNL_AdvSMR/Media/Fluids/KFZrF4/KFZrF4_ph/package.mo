within ORNL_AdvSMR.Media.Fluids.KFZrF4;
package KFZrF4_ph "KFZrF4 (explicit in p and h)"
extends KFZrF4.KFZrF4_base(
  ThermoStates=Choices.IndependentVariables.ph,
  final ph_explicit=true,
  final dT_explicit=false,
  final pT_explicit=false,
  smoothModel=true,
  onePhase=true);


annotation (Documentation(info="<html>

</html>"));
end KFZrF4_ph;
