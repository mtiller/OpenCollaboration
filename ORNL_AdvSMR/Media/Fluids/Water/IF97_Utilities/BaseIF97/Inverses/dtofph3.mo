within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function dtofph3 "inverse iteration in region 3: (d,T) = f(p,h)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input SI.Pressure delp "iteration accuracy";
  input SI.SpecificEnthalpy delh "iteration accuracy";
  output SI.Density d "density";
  output SI.Temperature T "temperature (K)";
  output Integer error "error flag: iteration failed if different from 0";
protected
  SI.Temperature Tguess "initial temperature";
  SI.Density dguess "initial density";
  Integer i "iteration counter";
  Real dh "Newton-error in h-direction";
  Real dp "Newton-error in p-direction";
  Real det "determinant of directional derivatives";
  Real deld "Newton-step in d-direction";
  Real delt "Newton-step in T-direction";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Common.NewtonDerivatives_ph nDerivs "derivatives needed in Newton iteration";
  Boolean found "flag for iteration success";
  Integer subregion "1 for subregion 3a, 2 for subregion 3b";
algorithm
  if p < data.PCRIT then
    // allow a 10 J margin inside the (well approximated) phase boundary
    subregion := if h < (Regions.hl_p(p) + 10.0) then 1 else if h > (
      Regions.hv_p(p) - 10.0) then 2 else 0;
    assert(subregion <> 0,
      "inverse iteration of dt from ph called in 2 phase region: this can not work");
  else
    //supercritical
    subregion := if h < Basic.h3ab_p(p) then 1 else 2;
  end if;
  T := if subregion == 1 then Basic.T3a_ph(p, h) else Basic.T3b_ph(p, h);
  d := if subregion == 1 then 1/Basic.v3a_ph(p, h) else 1/Basic.v3b_ph(p, h);
  i := 0;
  error := 0;
  while ((i < IterationData.IMAX) and not found) loop
    f := Basic.f3(d, T);
    nDerivs := Common.Helmholtz_ph(f);
    dh := nDerivs.h - h;
    dp := nDerivs.p - p;
    if ((abs(dh/h) <= delh) and (abs(dp/p) <= delp)) then
      found := true;
    end if;
    det := nDerivs.ht*nDerivs.pd - nDerivs.pt*nDerivs.hd;
    delt := (nDerivs.pd*dh - nDerivs.hd*dp)/det;
    deld := (nDerivs.ht*dp - nDerivs.pt*dh)/det;
    T := T - delt;
    d := d - deld;
    dguess := d;
    Tguess := T;
    i := i + 1;
    (d,T) := fixdT(dguess, Tguess);
  end while;
  if not found then
    error := 1;
  end if;
  assert(error <> 1, "error in inverse function dtofph3: iteration failed");
end dtofph3;
