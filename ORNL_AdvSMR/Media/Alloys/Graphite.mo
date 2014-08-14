within ORNL_AdvSMR.Media.Alloys;
package Graphite "GRAPHITE: Material properties for nuclear graphite"
  extends ORNL_AdvSMR.Media.Interfaces.PartialAlloy(materialName="Graphite",
      materialDescription="Nuclear-grade graphite");

  redeclare function extends density "Density as a function of temperature"
  algorithm
    rho := 1776.66 "Constant density (kg/m3)";
  end density;

  redeclare function extends thermalConductivity
    "Thermal conductivity as a function of temperature"
  algorithm
    k := 237.9808 - 0.3368*T + 2.3356e-4*T .^ 2 - 5.7930e-8*T .^ 3;
  end thermalConductivity;

  redeclare function extends specificHeatCapacity
    "Specific heat capacity as a function of temperature"
  algorithm
    cp := -143.9883 + 3.6677*T - 0.0022*T .^ 2 + 4.6251e-7*T .^ 3;
  end specificHeatCapacity;

  redeclare function extends linearExpansionCoefficient
    "Linear expansion coefficient as a function of temperature"
  algorithm
    alpha := 0;
  end linearExpansionCoefficient;

end Graphite;
