within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function boilingcurve_p "properties on the boiling curve"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output Common.IF97PhaseBoundaryProperties bpro "property record";
protected
  Common.GibbsDerivs g "dimensionless Gibbs funcion and dervatives";
  Common.HelmholtzDerivs f "dimensionless Helmholtz function and dervatives";
  SI.Pressure plim=min(p, data.PCRIT - 1e-7)
    "pressure limited to critical pressure - epsilon";
algorithm
  bpro.R := data.RH2O;
  bpro.T := Basic.tsat(plim);
  bpro.dpT := Basic.dptofT(bpro.T);
  bpro.region3boundary := bpro.T > data.TLIMIT1;
  if not bpro.region3boundary then
    g := Basic.g1(p, bpro.T);
    bpro.d := p/(bpro.R*bpro.T*g.pi*g.gpi);
    bpro.h := if p > plim then data.HCRIT else bpro.R*bpro.T*g.tau
      *g.gtau;
    bpro.s := g.R*(g.tau*g.gtau - g.g);
    bpro.cp := -bpro.R*g.tau*g.tau*g.gtautau;
    bpro.vt := bpro.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    bpro.vp := bpro.R*bpro.T/(p*p)*g.pi*g.pi*g.gpipi;
    bpro.pt := -p/bpro.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
    bpro.pd := -bpro.R*bpro.T*g.gpi*g.gpi/(g.gpipi);
  else
    bpro.d := rhol_p_R4b(plim);
    f := Basic.f3(bpro.d, bpro.T);
    bpro.h := hl_p_R4b(plim);
    // bpro.R*bpro.T*(f.tau*f.ftau + f.delta*f.fdelta);
    bpro.s := f.R*(f.tau*f.ftau - f.f);
    bpro.cv := bpro.R*(-f.tau*f.tau*f.ftautau);
    bpro.pt := bpro.R*bpro.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    bpro.pd := bpro.R*bpro.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end if;
end boilingcurve_p;
