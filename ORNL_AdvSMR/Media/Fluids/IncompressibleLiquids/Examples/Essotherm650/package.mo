within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.Examples;
package Essotherm650 "Essotherm thermal oil"
extends TableBased(
  mediumName="Essotherm 650",
  T_min=Cv.from_degC(0),
  T_max=Cv.from_degC(320),
  TinK=false,
  T0=273.15,
  tableDensity=[0, 909; 20, 897; 40, 884; 60, 871; 80, 859; 100, 846; 150, 813;
      200, 781; 250, 748; 300, 715; 320, 702],
  tableHeatCapacity=[0, 1770; 20, 1850; 40, 1920; 60, 1990; 80, 2060; 100, 2130;
      150, 2310; 200, 2490; 250, 2670; 300, 2850; 320, 2920],
  tableConductivity=[0, 0.1302; 20, 0.1288; 40, 0.1274; 60, 0.1260; 80, 0.1246;
      100, 0.1232; 150, 0.1197; 200, 0.1163; 250, 0.1128; 300, 0.1093; 320,
      0.1079],
  tableViscosity=[0, 14370; 20, 1917; 40, 424; 60, 134; 80, 54.5; 100, 26.64;
      150, 7.47; 200, 3.22; 250, 1.76; 300, 1.10; 320, 0.94],
  tableVaporPressure=[160, 3; 180, 10; 200, 40; 220, 100; 240, 300; 260, 600;
      280, 1600; 300, 3e3; 320, 5.5e3]);


annotation (Documentation(info="<html>

</html>"));
end Essotherm650;
