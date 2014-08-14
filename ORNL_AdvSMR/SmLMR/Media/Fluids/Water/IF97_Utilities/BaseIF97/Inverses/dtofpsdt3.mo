within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function dtofpsdt3 "inverse iteration in region 3: (d,T) = f(p,s)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input SI.Density dguess "guess density, e.g., from adjacent volume";
  input SI.Temperature Tguess "guess temperature, e.g., from adjacent volume";
  input SI.Pressure delp "iteration accuracy";
  input SI.SpecificEntropy dels "iteration accuracy";
  output SI.Density d "density";
  output SI.Temperature T "temperature (K)";
  output Integer error "error flag: iteration failed if different from 0";
protected
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
  SI.Density diter "density";
  SI.Temperature Titer "temperature (K)";
algorithm
  i := 0;
  error := 0;
  found := false;
  (diter,Titer) := fixdT(dguess, Tguess);
  while ((i < IterationData.IMAX) and not found) loop
    (d,T) := fixdT(diter, Titer);
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
    diter := d;
    Titer := T;
    i := i + 1;
  end while;
  if not found then
    error := 1;
  end if;
  assert(error <> 1,
    "error in inverse function dtofpsdt3: iteration failed");
end dtofpsdt3;
