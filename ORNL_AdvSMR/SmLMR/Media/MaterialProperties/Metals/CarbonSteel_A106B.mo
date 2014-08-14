within ORNL_AdvSMR.SmLMR.Media.MaterialProperties.Metals;
model CarbonSteel_A106B
  extends Common.MaterialTable(
    final materialName="ASME A106-B",
    final materialDescription="Carbon steel (%C <= 0.30)",
    final density=7763,
    final poissonRatio=0.3,
    tableYoungModulus=Functions.CtoKTable([21, 1.923e11; 93, 1.910e11; 149,
        1.889e11; 204, 1.861e11; 260, 1.820e11; 316, 1.772e11; 371, 1.710e11;
        427, 1.613e11; 482, 1.491e11; 538, 1.373e11]),
    tableUltimateStress=Functions.CtoKTable([21, 4.1412e8]),
    tableYieldStress=Functions.CtoKTable([40, 2.41e8; 100, 2.18e8; 150, 2.14e8;
        200, 2.08e8; 250, 1.98e8; 300, 1.83e8; 350, 1.75e8; 400, 1.68e8; 450,
        1.56e8; 475, 1.54e8]),
    tableLinearExpansionCoefficient=Functions.CtoKTable([21, 10.93e-6; 93,
        11.48e-6; 149, 11.88e-6; 204, 12.28e-6; 260, 12.64e-6; 316, 13.01e-6;
        371, 13.39e-6; 427, 13.77e-6; 482, 14.11e-6; 538, 14.35e-6]),
    tableSpecificHeatCapacity=Functions.CtoKTable([21, 478.2; 93, 494.1; 149,
        510.4; 204, 526.3; 260, 541.0; 316, 556.9; 371, 581.2; 427, 608.8; 482,
        665.3; 538, 684.6]),
    tableThermalConductivity=Functions.CtoKTable([21, 62.30; 93, 60.31; 149,
        57.45; 204, 54.68; 260, 51.57; 316, 48.97; 371, 46.38; 427, 43.96; 482,
        41.18; 538, 39.11]));

end CarbonSteel_A106B;
