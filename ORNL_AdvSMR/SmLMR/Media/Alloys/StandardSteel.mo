within ORNL_AdvSMR.SmLMR.Media.Alloys;
model StandardSteel
  extends MaterialProperties.Common.MaterialTable(
    final materialName="Standard Steel",
    final materialDescription="Standard Steel",
    final density=7763,
    final poissonRatio=0.3,
    tableYoungModulus=MaterialProperties.Functions.CtoKTable([21, 1.923e11]),
    tableUltimateStress=MaterialProperties.Functions.CtoKTable([21, 4.83e8]),
    tableYieldStress=MaterialProperties.Functions.CtoKTable([21, 2.76e8]),
    tableLinearExpansionCoefficient=MaterialProperties.Functions.CtoKTable([21,
        10.93e-6]),
    tableSpecificHeatCapacity=MaterialProperties.Functions.CtoKTable([21, 478.2]),

    tableThermalConductivity=MaterialProperties.Functions.CtoKTable([21, 62.30]));

end StandardSteel;
