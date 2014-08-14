within ORNL_AdvSMR.Media.MaterialProperties.Metals;
model AlloySteel_A335P12
  extends Common.MaterialTable(
    final materialName="ASME A335-P12",
    final materialDescription="Alloy steel (1 Cr - 1/2 Mo)",
    final density=7763,
    final poissonRatio=0.3,
    tableYoungModulus=Functions.CtoKTable([25, 2.050e11; 100, 2.000e11; 150,
        1.960e11; 200, 1.930e11; 250, 1.900e11; 300, 1.870e11; 350, 1.830e11;
        400, 1.790e11; 450, 1.740e11; 475, 1.720e11; 500, 1.697e11; 550,
        1.648e11]),
    tableUltimateStress=Functions.CtoKTable([21, 4.1404e8]),
    tableYieldStress=Functions.CtoKTable([40, 2.07e8; 100, 1.92e8; 150, 1.85e8;
        200, 1.81e8; 250, 1.79e8; 300, 1.76e8; 350, 1.66e8; 400, 1.56e8; 425,
        1.55e8; 450, 1.51e8; 475, 1.46e8; 500, 1.43e8; 525, 1.39e8]),
    tableLinearExpansionCoefficient=Functions.CtoKTable([50, 10.49e-6; 100,
        11.08e-6; 150, 11.63e-6; 200, 12.14e-6; 250, 12.60e-6; 300, 13.02e-6;
        350, 13.40e-6; 400, 13.74e-6; 425, 13.89e-6; 450, 14.02e-6; 500,
        14.28e-6; 550, 14.50e-6]),
    tableSpecificHeatCapacity=Functions.CtoKTable([25, 439.5; 100, 477.2; 150,
        498.1; 200, 523.3; 250, 540.0; 300, 560.9; 350, 577.5; 400, 602.8; 425,
        611.2; 450, 627.9; 475, 644.6; 500, 657.2; 550, 690.7]),
    tableThermalConductivity=Functions.CtoKTable([25, 41.9; 100, 42.2; 150,
        41.9; 200, 41.4; 250, 40.6; 300, 39.7; 350, 38.5; 400, 37.4; 425, 36.7;
        450, 36.3; 475, 35.7; 500, 35.0; 550, 34.0]));

end AlloySteel_A335P12;
