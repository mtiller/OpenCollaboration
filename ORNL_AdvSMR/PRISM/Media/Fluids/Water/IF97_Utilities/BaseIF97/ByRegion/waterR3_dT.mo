within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.ByRegion;
function waterR3_dT "standard properties for region 3, (d,T) as inputs"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature (K)";
  output Common.ThermoFluidSpecial.ThermoProperties_dT pro
    "thermodynamic property collection";
protected
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
algorithm
  f := Basic.f3(d, T);
  pro := Common.ThermoFluidSpecial.helmholtzToProps_dT(f);
  assert(pro.p <= 100.0e6,
    "IF97 medium function waterR3_dT: the input pressure (= "
     + String(pro.p) + " Pa) is higher than 100 Mpa");
end waterR3_dT;
