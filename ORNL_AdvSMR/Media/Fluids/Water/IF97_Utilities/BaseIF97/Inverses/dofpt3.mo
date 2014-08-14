within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function dofpt3 "inverse iteration in region 3: (d) = f(p,T)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  input SI.Pressure delp "iteration converged if (p-pre(p) < delp)";
  output SI.Density d "density";
  output Integer error=0 "error flag: iteration failed if different from 0";
protected
  SI.Density dguess "guess density";
  Integer i=0 "loop counter";
  Real dp "pressure difference";
  SI.Density deld "density step";
  Common.HelmholtzDerivs f
    "dimensionless Helmholtz function and dervatives w.r.t. delta and tau";
  Common.NewtonDerivatives_pT nDerivs "derivatives needed in Newton iteration";
  Boolean found=false "flag for iteration success";
  Boolean supercritical "flag, true for supercritical states";
  Boolean liquid "flag, true for liquid states";
  SI.Density dmin "lower density limit";
  SI.Density dmax "upper density limit";
  SI.Temperature Tmax "maximum temperature";
algorithm
  assert(p >= data.PLIMIT4A,
    "BaseIF97.dofpt3: function called outside of region 3! p too low\n" +
    "p = " + String(p) + " Pa < " + String(data.PLIMIT4A) + " Pa");
  assert(T >= data.TLIMIT1,
    "BaseIF97.dofpt3: function called outside of region 3! T too low\n" +
    "T = " + String(T) + " K < " + String(data.TLIMIT1) + " K");
  assert(p >= Regions.boundary23ofT(T),
    "BaseIF97.dofpt3: function called outside of region 3! T too high\n" +
    "p = " + String(p) + " Pa, T = " + String(T) + " K");
  supercritical := p > data.PCRIT;
  dmax := dofp13(p);
  dmin := dofp23(p);
  Tmax := Regions.boundary23ofp(p);
  if supercritical then
    dguess := dmin + (T - data.TLIMIT1)/(data.TLIMIT1 - Tmax)*(dmax - dmin);
    //this may need improvement!!
  else
    liquid := T < Basic.tsat(p);
    if liquid then
      dguess := 0.5*(Regions.rhol_p_R4b(p) + dmax);
    else
      dguess := 0.5*(Regions.rhov_p_R4b(p) + dmin);
    end if;
  end if;
  while ((i < IterationData.IMAX) and not found) loop
    d := dguess;
    f := Basic.f3(d, T);
    nDerivs := Common.Helmholtz_pT(f);
    dp := nDerivs.p - p;
    if (abs(dp/p) <= delp) then
      found := true;
    end if;
    deld := dp/nDerivs.pd;
    d := d - deld;
    if d > dmin and d < dmax then
      dguess := d;
    else
      if d > dmax then
        dguess := dmax - sqrt(Modelica.Constants.eps);
        // put it on the correct spot just inside the boundary here instead
      else
        dguess := dmin + sqrt(Modelica.Constants.eps);
      end if;
    end if;
    i := i + 1;
  end while;
  if not found then
    error := 1;
  end if;
  assert(error <> 1, "error in inverse function dofpt3: iteration failed");
end dofpt3;
