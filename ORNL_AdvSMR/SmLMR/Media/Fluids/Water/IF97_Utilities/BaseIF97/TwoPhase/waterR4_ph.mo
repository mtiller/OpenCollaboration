within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.TwoPhase;
function waterR4_ph
  "Water/Steam properties in region 4 of IAPWS/IF97 (two-phase)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  output Common.ThermoFluidSpecial.ThermoProperties_ph pro
    "thermodynamic property collection";
protected
  SI.Density dl "liquid density";
  SI.Density dv "vapour density";
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
  Real x "dryness fraction";
  Real dpT "derivative of saturation curve";
algorithm
  pro.T := Basic.tsat(p);
  dpT := Basic.dptofT(pro.T);
  dl := Regions.rhol_p_R4b(p);
  dv := Regions.rhov_p_R4b(p);
  if p < data.PLIMIT4A then
    gl := Basic.g1(p, pro.T);
    gv := Basic.g2(p, pro.T);
    liq := Common.gibbsToBoundaryProps(gl);
    vap := Common.gibbsToBoundaryProps(gv);
  else
    fl := Basic.f3(dl, pro.T);
    fv := Basic.f3(dv, pro.T);
    liq := Common.helmholtzToBoundaryProps(fl);
    vap := Common.helmholtzToBoundaryProps(fv);
  end if;
  x := if (vap.h <> liq.h) then (h - liq.h)/(vap.h - liq.h)
     else 1.0;
  pro.d := liq.d*vap.d/(vap.d + x*(liq.d - vap.d));
  pro.u := x*vap.u + (1 - x)*liq.u;
  pro.s := x*vap.s + (1 - x)*liq.s;
  pro.cp := Modelica.Constants.inf;
  pro.cv := Common.cv2Phase(
                    liq,
                    vap,
                    x,
                    pro.T,
                    p);
  pro.kappa := 1/(pro.d*p)*dpT*dpT*pro.T/pro.cv;
  pro.a := Modelica.Constants.inf;
  pro.R := data.RH2O;
  pro.ddph := pro.d*(pro.d*pro.cv/dpT + 1.0)/(dpT*pro.T);
  pro.ddhp := -pro.d*pro.d/(dpT*pro.T);
end waterR4_ph;
