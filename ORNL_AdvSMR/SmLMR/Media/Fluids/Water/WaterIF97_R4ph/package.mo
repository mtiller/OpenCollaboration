within ORNL_AdvSMR.SmLMR.Media.Fluids.Water;
package WaterIF97_R4ph "region 4 water according to IF97 standard"
extends WaterIF97_fixedregion(
  final Region=4,
  ThermoStates=Choices.IndependentVariables.ph,
  final ph_explicit=true,
  final dT_explicit=false,
  final pT_explicit=false,
  smoothModel=true,
  onePhase=false);


annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R4ph;
