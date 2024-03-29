within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.TwoPhase;
function waterLiq_p "properties on the liquid phase boundary of region 4"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output Common.PhaseBoundaryProperties liq
    "liquid thermodynamic property collection";
protected
  SI.Temperature Tsat "saturation temperature";
  Real dpT "derivative of saturation pressure w.r.t. temperature";
  SI.Density dl "liquid density";
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
algorithm
  Tsat := Basic.tsat(p);
  dpT := Basic.dptofT(Tsat);
  if p < data.PLIMIT4A then
    g := Basic.g1(p, Tsat);
    liq := Common.gibbsToBoundaryProps(g);
  else
    dl := Regions.rhol_p_R4b(p);
    f := Basic.f3(dl, Tsat);
    liq := Common.helmholtzToBoundaryProps(f);
  end if;
end waterLiq_p;
