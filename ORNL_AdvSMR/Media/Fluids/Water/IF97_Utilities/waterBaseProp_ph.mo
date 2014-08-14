within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities;
function waterBaseProp_ph "intermediate property record for water"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  input Integer region=0
    "if 0, do region computation, otherwise assume the region is this input";
  output Common.IF97BaseTwoPhase aux "auxiliary record";
protected
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz funcion and dervatives w.r.t. delta and tau";
  Integer error "error flag for inverse iterations";
  SI.SpecificEnthalpy h_liq "liquid specific enthalpy";
  SI.Density d_liq "liquid density";
  SI.SpecificEnthalpy h_vap "vapour specific enthalpy";
  SI.Density d_vap "vapour density";
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
  SI.Temperature t1
    "temperature at phase boundary, using inverse from region 1";
  SI.Temperature t2
    "temperature at phase boundary, using inverse from region 2";
algorithm
  aux.region := if region == 0 then (if phase == 2 then 4 else
    BaseIF97.Regions.region_ph(
    p=p,
    h=h,
    phase=phase)) else region;
  aux.phase := if phase <> 0 then phase else if aux.region == 4 then 2 else 1;
  aux.p := max(p, 611.657);
  aux.h := max(h, 1e3);
  aux.R := BaseIF97.data.RH2O;
  if (aux.region == 1) then
    aux.T := BaseIF97.Basic.tph1(aux.p, aux.h);
    g := BaseIF97.Basic.g1(p, aux.T);
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
    aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi));
    aux.x := 0.0;
    aux.dpT := -aux.vt/aux.vp;
  elseif (aux.region == 2) then
    aux.T := BaseIF97.Basic.tph2(aux.p, aux.h);
    g := BaseIF97.Basic.g2(p, aux.T);
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
    aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi));
    aux.x := 1.0;
    aux.dpT := -aux.vt/aux.vp;
  elseif (aux.region == 3) then
    (aux.rho,aux.T,error) := BaseIF97.Inverses.dtofph3(
      p=aux.p,
      h=aux.h,
      delp=1.0e-7,
      delh=1.0e-6);
    f := BaseIF97.Basic.f3(aux.rho, aux.T);
    aux.h := aux.R*aux.T*(f.tau*f.ftau + f.delta*f.fdelta);
    aux.s := aux.R*(f.tau*f.ftau - f.f);
    aux.pd := aux.R*aux.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    aux.pt := aux.R*aux.rho*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    aux.cv := abs(aux.R*(-f.tau*f.tau*f.ftautau))
      "can be close to neg. infinity near critical point";
    aux.cp := (aux.rho*aux.rho*aux.pd*aux.cv + aux.T*aux.pt*aux.pt)/(aux.rho*
      aux.rho*aux.pd);
    aux.x := 0.0;
    aux.dpT := aux.pt;
    /*safety against div-by-0 in initialization*/
  elseif (aux.region == 4) then
    h_liq := hl_p(p);
    h_vap := hv_p(p);
    aux.x := if (h_vap <> h_liq) then (h - h_liq)/(h_vap - h_liq) else 1.0;
    if p < BaseIF97.data.PLIMIT4A then
      t1 := BaseIF97.Basic.tph1(aux.p, h_liq);
      t2 := BaseIF97.Basic.tph2(aux.p, h_vap);
      gl := BaseIF97.Basic.g1(aux.p, t1);
      gv := BaseIF97.Basic.g2(aux.p, t2);
      liq := Common.gibbsToBoundaryProps(gl);
      vap := Common.gibbsToBoundaryProps(gv);
      aux.T := t1 + aux.x*(t2 - t1);
    else
      aux.T := BaseIF97.Basic.tsat(aux.p);
      // how to avoid ?
      d_liq := rhol_T(aux.T);
      d_vap := rhov_T(aux.T);
      fl := BaseIF97.Basic.f3(d_liq, aux.T);
      fv := BaseIF97.Basic.f3(d_vap, aux.T);
      liq := Common.helmholtzToBoundaryProps(fl);
      vap := Common.helmholtzToBoundaryProps(fv);
      //  aux.dpT := BaseIF97.Basic.dptofT(aux.T);
    end if;
    aux.dpT := if (liq.d <> vap.d) then (vap.s - liq.s)*liq.d*vap.d/(liq.d -
      vap.d) else BaseIF97.Basic.dptofT(aux.T);
    aux.s := liq.s + aux.x*(vap.s - liq.s);
    aux.rho := liq.d*vap.d/(vap.d + aux.x*(liq.d - vap.d));
    aux.cv := Common.cv2Phase(
      liq,
      vap,
      aux.x,
      aux.T,
      p);
    aux.cp := liq.cp + aux.x*(vap.cp - liq.cp);
    aux.pt := liq.pt + aux.x*(vap.pt - liq.pt);
    aux.pd := liq.pd + aux.x*(vap.pd - liq.pd);
  elseif (aux.region == 5) then
    (aux.T,error) := BaseIF97.Inverses.tofph5(
      p=aux.p,
      h=aux.h,
      reldh=1.0e-7);
    assert(error == 0, "error in inverse iteration of steam tables");
    g := BaseIF97.Basic.g5(aux.p, aux.T);
    aux.s := aux.R*(g.tau*g.gtau - g.g);
    aux.rho := p/(aux.R*aux.T*g.pi*g.gpi);
    aux.vt := aux.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    aux.vp := aux.R*aux.T/(p*p)*g.pi*g.pi*g.gpipi;
    aux.cp := -aux.R*g.tau*g.tau*g.gtautau;
    aux.cv := aux.R*(-g.tau*g.tau*g.gtautau + ((g.gpi - g.tau*g.gtaupi)*(g.gpi
       - g.tau*g.gtaupi)/g.gpipi));
    aux.dpT := -aux.vt/aux.vp;
  else
    assert(false, "error in region computation of IF97 steam tables" + "(p = "
       + String(p) + ", h = " + String(h) + ")");
  end if;
end waterBaseProp_ph;
