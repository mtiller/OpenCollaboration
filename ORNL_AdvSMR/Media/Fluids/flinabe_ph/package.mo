within ORNL_AdvSMR.Media.Fluids;
package flinabe_ph "Flinabe (explicit in p and h)"
extends flinabe_base(
  ThermoStates=Choices.IndependentVariables.ph,
  final ph_explicit=true,
  final dT_explicit=false,
  final pT_explicit=false,
  smoothModel=false,
  onePhase=false);


annotation (Documentation(info="<html>

</html>"));
end flinabe_ph;
