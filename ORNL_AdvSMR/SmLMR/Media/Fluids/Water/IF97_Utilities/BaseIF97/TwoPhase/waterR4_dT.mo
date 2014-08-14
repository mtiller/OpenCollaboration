within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.TwoPhase;
function waterR4_dT "Water properties in region 4 as function of d and T"

  extends Modelica.Icons.Function;
  input SI.Density d "Density";
  input SI.Temperature T "temperature";
  output Common.ThermoFluidSpecial.ThermoProperties_dT pro
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
  pro.p := Basic.psat(T);
  dpT := Basic.dptofT(T);
  dl := Regions.rhol_p_R4b(pro.p);
  dv := Regions.rhov_p_R4b(pro.p);
  if pro.p < data.PLIMIT4A then
    gl := Basic.g1(pro.p, T);
    gv := Basic.g2(pro.p, T);
    liq := Common.gibbsToBoundaryProps(gl);
    vap := Common.gibbsToBoundaryProps(gv);
  else
    fl := Basic.f3(dl, T);
    fv := Basic.f3(dv, T);
    liq := Common.helmholtzToBoundaryProps(fl);
    vap := Common.helmholtzToBoundaryProps(fv);
  end if;
  x := if (vap.d <> liq.d) then (1/d - 1/liq.d)/(1/vap.d - 1/
    liq.d) else 1.0;
  pro.u := x*vap.u + (1 - x)*liq.u;
  pro.h := x*vap.h + (1 - x)*liq.h;
  pro.cp := Modelica.Constants.inf;
  pro.cv := Common.cv2Phase(
                    liq,
                    vap,
                    x,
                    T,
                    pro.p);
  pro.kappa := 1/(d*pro.p)*dpT*dpT*T/pro.cv;
  pro.a := Modelica.Constants.inf;
  pro.R := data.RH2O;
  pro.dudT := (pro.p - T*dpT)/(d*d);
end waterR4_dT;
