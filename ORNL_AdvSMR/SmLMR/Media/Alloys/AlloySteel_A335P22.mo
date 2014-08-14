within ORNL_AdvSMR.SmLMR.Media.Alloys;
model AlloySteel_A335P22
  extends MaterialProperties.Common.MaterialTable(
    final materialName="ASME A335-P22",
    final materialDescription="Alloy steel (2 1/4 Cr - 1 Mo)",
    final density=7763,
    final poissonRatio=0.3,
    tableYoungModulus=MaterialProperties.Functions.CtoKTable([21, 2.061e11; 93,
        2.034e11; 149, 1.999e11; 204, 1.972e11; 260, 1.930e11; 316, 1.889e11;
        371, 1.834e11; 427, 1.772e11; 482, 1.689e11; 538, 1.586e11]),
    tableUltimateStress=MaterialProperties.Functions.CtoKTable([21, 4.1412e8]),

    tableYieldStress=MaterialProperties.Functions.CtoKTable([21, 2.07e8; 93,
        1.92e8; 149, 1.87e8; 204, 1.86e8; 260, 1.86e8; 316, 1.86e8; 371, 1.86e8;
        427, 1.84e8; 482, 1.77e8; 538, 1.63e8]),
    tableLinearExpansionCoefficient=MaterialProperties.Functions.CtoKTable([21,
        10.93e-6; 93, 11.48e-6; 149, 11.88e-6; 204, 12.28e-6; 260, 12.64e-6;
        316, 13.01e-6; 371, 13.39e-6; 427, 13.77e-6; 482, 14.11e-6; 538,
        14.35e-6]),
    tableSpecificHeatCapacity=MaterialProperties.Functions.CtoKTable([21, 478.2;
        93, 494.1; 149, 510.4; 204, 526.3; 260, 541.0; 316, 556.9; 371, 581.2;
        427, 608.8; 482, 665.3; 538, 684.6]),
    tableThermalConductivity=MaterialProperties.Functions.CtoKTable([21, 62.30;
        93, 60.31; 149, 57.45; 204, 54.68; 260, 51.57; 316, 48.97; 371, 46.38;
        427, 43.96; 482, 41.18; 538, 39.11]));

end AlloySteel_A335P22;
