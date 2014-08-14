within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function waterBaseProp_pT
  "intermediate property record for water (p and T prefered states)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature";
  input Integer region=0
    "if 0, do region computation, otherwise assume the region is this input";
  output Common.IF97BaseTwoPhase aux "auxiliary record";
protected
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
  Integer error "error flag for inverse iterations";
algorithm
  aux.phase := 1;
  aux.region := if region == 0 then BaseIF97.Regions.region_pT(p=p, T=T) else
    region;
  aux.R := BaseIF97.data.RH2O;
  aux.p := p;
  aux.T := T;
  if (aux.region == 1) then
    g := BaseIF97.Basic.g1(p, T);
    aux.h := aux.R*aux.T*g.tau*g.gtau;
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := p/(aux.R*T*g.pi*g.gpi);
    aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi));
    aux.x := 0.0;
  elseif (aux.region == 2) then
    g := BaseIF97.Basic.g2(p, T);
    aux.h := aux.R*aux.T*g.tau*g.gtau;
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := p/(aux.R*T*g.pi*g.gpi);
    aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi));
    aux.x := 1.0;
  elseif (aux.region == 3) then
    (aux.rho,error) := BaseIF97.Inverses.dofpt3(
      p=p,
      T=T,
      delp=1.0e-7);
    f := BaseIF97.Basic.f3(aux.rho, T);
    aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta);
    aux.s := aux.R*(f.tau*f.ftau - f.f);
    aux.pd := aux.R*T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
    aux.x := 0.0;
  elseif (aux.region == 5) then
    g := BaseIF97.Basic.g5(p, T);
    aux.h := aux.R*aux.T*g.tau*g.gtau;
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := p/(aux.R*T*g.pi*g.gpi);
    aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*T/(p*p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi));
  else
    assert(false, "error in region computation of IF97 steam tables" + "(p = "
       + String(p) + ", T = " + String(T) + ")");
  end if;
end waterBaseProp_pT;
