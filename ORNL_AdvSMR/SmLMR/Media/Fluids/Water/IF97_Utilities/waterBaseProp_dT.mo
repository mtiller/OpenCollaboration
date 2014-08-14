within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities;
function waterBaseProp_dT
  "intermediate property record for water (d and T prefered states)"
  extends Modelica.Icons.Function;
  input SI.Density rho "density";
  input SI.Temperature T "temperature";
  input Integer phase=0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  input Integer region=0
    "if 0, do region computation, otherwise assume the region is this input";
  output Common.IF97BaseTwoPhase aux "auxiliary record";
protected
  SI.SpecificEnthalpy h_liq "liquid specific enthalpy";
  SI.Density d_liq "liquid density";
  SI.SpecificEnthalpy h_vap "vapour specific enthalpy";
  SI.Density d_vap "vapour density";
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
  Common.PhaseBoundaryProperties liq "phase boundary property record";
  Common.PhaseBoundaryProperties vap "phase boundary property record";
  Common.GibbsDerivs gl
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.GibbsDerivs gv
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs fl
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Common.HelmholtzDerivs fv
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Integer error "error flag for inverse iterations";
algorithm
  aux.region := if region == 0 then (if phase == 2 then 4 else
    BaseIF97.Regions.region_dT(
                d=rho,
                T=T,
                phase=phase)) else region;
  aux.phase := if aux.region == 4 then 2 else 1;
  aux.R := BaseIF97.data.RH2O;
  aux.rho := rho;
  aux.T := T;
  if (aux.region == 1) then
    (aux.p,error) := BaseIF97.Inverses.pofdt125(
                  d=rho,
                  T=T,
                  reldd=1.0e-8,
                  region=1);
    g := BaseIF97.Basic.g1(aux.p, T);
    aux.h := aux.R*aux.T*g.tau*g.gtau;
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
    aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)
      *(g.gpi - g.tau*g.gtaupi)/g.gpipi));
    aux.x := 0.0;
  elseif (aux.region == 2) then
    (aux.p,error) := BaseIF97.Inverses.pofdt125(
                  d=rho,
                  T=T,
                  reldd=1.0e-8,
                  region=2);
    g := BaseIF97.Basic.g2(aux.p, T);
    aux.h := aux.R*aux.T*g.tau*g.gtau;
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
    aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)
      *(g.gpi - g.tau*g.gtaupi)/g.gpipi));
    aux.x := 1.0;
  elseif (aux.region == 3) then
    f := BaseIF97.Basic.f3(rho, T);
    aux.p := aux.R*rho*T*f.delta*f.fdelta;
    aux.h := aux.R*T*(f.tau*f.ftau + f.delta*f.fdelta);
    aux.s := aux.R*(f.tau*f.ftau - f.f);
    aux.pd := aux.R*T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    aux.pt := aux.R*rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)
      /(aux.rho*aux.rho*aux.pd);
    aux.cv := aux.R*(-f.tau*f.tau*f.ftautau);
    aux.x := 0.0;
  elseif (aux.region == 4) then
    aux.p := BaseIF97.Basic.psat(T);
    d_liq := rhol_T(T);
    d_vap := rhov_T(T);
    h_liq := hl_p(aux.p);
    h_vap := hv_p(aux.p);
    aux.x := if (d_vap <> d_liq) then (1/rho - 1/d_liq)/(1/d_vap -
      1/d_liq) else 1.0;
    aux.h := h_liq + aux.x*(h_vap - h_liq);
    if T < BaseIF97.data.TLIMIT1 then
      gl := BaseIF97.Basic.g1(aux.p, T);
      gv := BaseIF97.Basic.g2(aux.p, T);
      liq := Common.gibbsToBoundaryProps(gl);
      vap := Common.gibbsToBoundaryProps(gv);
    else
      fl := BaseIF97.Basic.f3(d_liq, T);
      fv := BaseIF97.Basic.f3(d_vap, T);
      liq := Common.helmholtzToBoundaryProps(fl);
      vap := Common.helmholtzToBoundaryProps(fv);
    end if;
    aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d
      /(liq.d - vap.d) else BaseIF97.Basic.dptofT(aux.T);
    aux.s := liq.s + aux.x*(vap.s - liq.s);
    aux.cv := Common.cv2Phase(
                  liq,
                  vap,
                  aux.x,
                  aux.T,
                  aux.p);
    aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
    aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
    aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
  elseif (aux.region == 5) then
    (aux.p,error) := BaseIF97.Inverses.pofdt125(
                  d=rho,
                  T=T,
                  reldd=1.0e-8,
                  region=5);
    g := BaseIF97.Basic.g2(aux.p, T);
    aux.h := aux.R*aux.T*g.tau*g.gtau;
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := aux.p/(aux.R*T*g.pi*g.gpi);
    aux.vt := aux.R/aux.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*T/(aux.p*aux.p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)
      *(g.gpi - g.tau*g.gtaupi)/g.gpipi));
  else
    assert(false,
      "error in region computation of IF97 steam tables" +
      "(rho = " + String(rho) + ", T = " + String(T) + ")");
  end if;
end waterBaseProp_dT;
