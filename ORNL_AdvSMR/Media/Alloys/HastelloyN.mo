within ORNL_AdvSMR.Media.Alloys;
model HastelloyN "Material properties for Hastelloy N (R)"
  extends Alloys.Common.MaterialTable(
    final materialName="Hastelloy N",
    final materialDescription="Nickel-base alloy (71Ni-7Cr-16Mo-5Fe-1Si)",
    final density=8860,
    final poissonRatio=0.3,
    tableYoungModulus=Alloys.Functions.CtoKTable([21, 2.061e11; 93, 2.034e11;
        149, 1.999e11; 204, 1.972e11; 260, 1.930e11; 316, 1.889e11; 371,
        1.834e11; 427, 1.772e11; 482, 1.689e11; 538, 1.586e11]),
    tableUltimateStress=Alloys.Functions.CtoKTable([21, 4.1412e8]),
    tableYieldStress=Alloys.Functions.CtoKTable([21, 2.07e8; 93, 1.92e8; 149,
        1.87e8; 204, 1.86e8; 260, 1.86e8; 316, 1.86e8; 371, 1.86e8; 427, 1.84e8;
        482, 1.77e8; 538, 1.63e8]),
    tableLinearExpansionCoefficient=Alloys.Functions.CtoKTable([204, 11.6e-6;
        316, 12.3e-6; 427, 12.7e-6; 538, 13.4e-6; 649, 14.0e-6; 760, 14.7e-6;
        871, 15.3e-6; 982, 15.8e-6]),
    tableSpecificHeatCapacity=Alloys.Functions.CtoKTable([100, 419; 200, 440;
        300, 456; 400, 469; 480, 477; 540, 485; 570, 523; 590, 565; 620, 586;
        660, 582; 680, 578; 700, 578]),
    tableThermalConductivity=Alloys.Functions.CtoKTable([100, 11.5; 200, 13.1;
        300, 14.4; 400, 16.5; 500, 18.0; 600, 20.3; 700, 23.6]));

end HastelloyN;
