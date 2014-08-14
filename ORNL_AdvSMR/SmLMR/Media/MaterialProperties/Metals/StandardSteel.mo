within ORNL_AdvSMR.SmLMR.Media.MaterialProperties.Metals;
model StandardSteel
  extends Common.MaterialTable(
    final materialName="Standard Steel",
    final materialDescription="Standard Steel",
    final density=7763,
    final poissonRatio=0.3,
    tableYoungModulus=Functions.CtoKTable([21, 1.923e11]),
    tableUltimateStress=Functions.CtoKTable([21, 4.83e8]),
    tableYieldStress=Functions.CtoKTable([21, 2.76e8]),
    tableLinearExpansionCoefficient=Functions.CtoKTable([21, 10.93e-6]),
    tableSpecificHeatCapacity=Functions.CtoKTable([21, 478.2]),
    tableThermalConductivity=Functions.CtoKTable([21, 62.30]));

end StandardSteel;
