within ORNL_AdvSMR.Media.DataDefinitions.PolyBased;
record PolyBasedFluid
  "Constants for a polynomial based fluid in the form C1*x^npol+C2*x^(npol-1)+..Cn"
  extends Modelica.Icons.Record;
  constant Units.VolumetricExpansionCoefficient beta_const
    "Thermal expansion coefficient at constant pressure";
  constant Units.IsothermalCompressibility kappa_const
    "Isothermal compressibility";
  constant Units.AbsolutePressure reference_p
    "pressure at which table based date is taken at";
  constant Units.Density reference_d "Density in reference conditions";
  constant Units.SpecificEnthalpy reference_h
    "Specific enthalpy in reference conditions";
  constant Units.SpecificEntropy reference_s
    "Specific entropy in reference conditions";
  constant Integer npol_rho(min=0) "degree of density polynomial";
  constant Integer npol_Cp(min=0) "degree of heat capacity polynomial";
  constant Integer npol_lam(min=0) "degree of conductivity polynomial";
  constant Integer npol_eta(min=0) "degree of viscosity polynomial";
  constant Integer npol_pVap(min=0) "degree of vapor pressure polynomial";
  constant Real[npol_rho + 1] polyDensity "density polynomial d(T) unit kg/m3";
  constant Real[npol_Cp + 1] polyHeatCapacity
    "specific heat polynomial c(T) in J/kgK";
  constant Real[npol_lam + 1] polyConductivity
    "thermal conductivity polynomial lam(T) unit W/mK";
  constant Real[npol_eta + 1] polyViscosity
    "viscosity polynomial normally on log(v)=f(1/T) but special for jet fuels";
  constant Real[npol_pVap + 1] polyVaporPressure
    "vapor pressure polynomial p(T)";
end PolyBasedFluid;
