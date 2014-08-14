within ORNL_AdvSMR.SmLMR.Media.Fluids.Water;
package WaterIF97_R5ph "region 5 water according to IF97 standard"
extends WaterIF97_fixedregion(
  ThermoStates=Choices.IndependentVariables.ph,
  final Region=5,
  final ph_explicit=true,
  final dT_explicit=false,
  final pT_explicit=false,
  smoothModel=true,
  onePhase=true);


annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R5ph;
