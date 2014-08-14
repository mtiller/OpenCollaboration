within ORNL_AdvSMR.PRISM.Media.Fluids.Water;
package WaterIF97_R1pT "region 1 (liquid) water according to IF97 standard"
extends WaterIF97_fixedregion(
  ThermoStates=Choices.IndependentVariables.pT,
  final Region=1,
  final ph_explicit=false,
  final dT_explicit=false,
  final pT_explicit=true,
  smoothModel=true,
  onePhase=true);


annotation (Documentation(info="<html>

</html>"));
end WaterIF97_R1pT;
