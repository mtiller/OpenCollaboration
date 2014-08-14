within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.ByRegion;
function waterR1_pT "standard properties for region 1, (p,T) as inputs"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output Common.ThermoFluidSpecial.ThermoProperties_pT pro
    "thermodynamic property collection";

protected
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
algorithm
  g := Basic.g1(p, T);
  pro := Common.ThermoFluidSpecial.gibbsToProps_pT(g);
end waterR1_pT;
