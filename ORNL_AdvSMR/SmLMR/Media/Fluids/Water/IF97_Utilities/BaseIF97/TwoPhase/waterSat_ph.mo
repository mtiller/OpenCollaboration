within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.TwoPhase;
function waterSat_ph
  "Water saturation properties in the 2-phase region (4) as f(p,h)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output Common.SaturationProperties pro "thermodynamic property collection";
protected
  SI.Density dl "liquid density";
  SI.Density dv "vapour density";
  Common.GibbsDerivs gl
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.GibbsDerivs gv
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Common.HelmholtzDerivs fl
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Common.HelmholtzDerivs fv
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
algorithm
  pro.h := h;
  pro.p := p;
  pro.T := Basic.tsat(p);
  pro.dpT := Basic.dptofT(pro.T);
  if p < data.PLIMIT4A then
    gl := Basic.g1(p, pro.T);
    gv := Basic.g2(p, pro.T);
    pro.liq := Common.gibbsToBoundaryProps(gl);
    pro.vap := Common.gibbsToBoundaryProps(gv);
  else
    dl := Regions.rhol_p_R4b(p);
    dv := Regions.rhov_p_R4b(p);
    fl := Basic.f3(dl, pro.T);
    fv := Basic.f3(dv, pro.T);
    pro.liq := Common.helmholtzToBoundaryProps(fl);
    pro.vap := Common.helmholtzToBoundaryProps(fv);
  end if;
  pro.x := if (h < pro.liq.h) then 0.0 else if (pro.vap.h <>
    pro.liq.h) then (h - pro.liq.h)/(pro.vap.h - pro.liq.h)
     else 1.0;
  pro.d := pro.liq.d*pro.vap.d/(pro.vap.d + pro.x*(pro.liq.d -
    pro.vap.d));
  pro.u := pro.x*pro.vap.u + (1 - pro.x)*pro.liq.u;
  pro.s := pro.x*pro.vap.s + (1 - pro.x)*pro.liq.s;
  pro.cp := Modelica.Constants.inf;
  pro.cv := Common.cv2Phase(
                    pro.liq,
                    pro.vap,
                    pro.x,
                    pro.T,
                    p);
  pro.kappa := 1/(pro.d*p)*pro.dpT*pro.dpT*pro.T/pro.cv;
  pro.R := data.RH2O;
end waterSat_ph;
