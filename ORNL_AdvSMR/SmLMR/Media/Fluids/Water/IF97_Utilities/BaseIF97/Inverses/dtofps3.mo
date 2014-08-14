within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function dtofps3 "inverse iteration in region 3: (d,T) = f(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input SI.Pressure delp "iteration accuracy";
  input SI.SpecificEntropy dels "iteration accuracy";
  output SI.Density d "density";
  output SI.Temperature T "temperature (K)";
  output Integer error "error flag: iteration failed if different from 0";
protected
  SI.Temperature Tguess "initial temperature";
  SI.Density dguess "initial density";
  Integer i "iteration counter";
  Real ds "Newton-error in s-direction";
  Real dp "Newton-error in p-direction";
  Real det "determinant of directional derivatives";
  Real deld "Newton-step in d-direction";
  Real delt "Newton-step in T-direction";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Common.NewtonDerivatives_ps nDerivs "derivatives needed in Newton iteration";
  Boolean found "flag for iteration success";
  Integer subregion "1 for subregion 3a, 2 for subregion 3b";
algorithm
  i := 0;
  error := 0;
  found := false;
  if p < data.PCRIT then
    // allow a 1 J/K margin inside the (well approximated) phase boundary
    subregion := if s < (Regions.sl_p(p) + 10.0) then 1 else
      if s > (Regions.sv_p(p) - 10.0) then 2 else 0;
    assert(subregion <> 0,
      "inverse iteration of dt from ps called in 2 phase region: this is illegal!");
  else
    subregion := if s < data.SCRIT then 1 else 2;
  end if;
  T := if subregion == 1 then Basic.T3a_ps(p, s) else
    Basic.T3b_ps(p, s);
  d := if subregion == 1 then 1/Basic.v3a_ps(p, s) else 1/
    Basic.v3b_ps(p, s);
  while ((i < IterationData.IMAX) and not found) loop
    f := Basic.f3(d, T);
    nDerivs := Common.Helmholtz_ps(f);
    ds := nDerivs.s - s;
    dp := nDerivs.p - p;
    if ((abs(ds/s) <= dels) and (abs(dp/p) <= delp)) then
      found := true;
    end if;
    det := nDerivs.st*nDerivs.pd - nDerivs.pt*nDerivs.sd;
    delt := (nDerivs.pd*ds - nDerivs.sd*dp)/det;
    deld := (nDerivs.st*dp - nDerivs.pt*ds)/det;
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
  assert(error <> 1,
    "error in inverse function dtofps3: iteration failed");
end dtofps3;
