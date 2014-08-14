within ORNL_AdvSMR.Media.Alloys;
model StandardSteel
  extends Alloys.Common.MaterialTable(
    final materialName="Standard Steel",
    final materialDescription="Standard Steel",
    final density=7763,
    final poissonRatio=0.3,
    tableYoungModulus=Alloys.Functions.CtoKTable([21, 1.923e11]),
    tableUltimateStress=Alloys.Functions.CtoKTable([21, 4.83e8]),
    tableYieldStress=Alloys.Functions.CtoKTable([21, 2.76e8]),
    tableLinearExpansionCoefficient=Alloys.Functions.CtoKTable([21, 10.93e-6]),

    tableSpecificHeatCapacity=Alloys.Functions.CtoKTable([21, 478.2]),
    tableThermalConductivity=Alloys.Functions.CtoKTable([21, 62.30]));

end StandardSteel;
