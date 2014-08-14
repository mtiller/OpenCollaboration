within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function tofps5 "inverse iteration in region 5: (p,T) = f(p,s)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input SI.SpecificEnthalpy relds "iteration accuracy";
  output SI.Temperature T "temperature (K)";
  output Integer error "error flag: iteration failed if different from 0";

protected
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  SI.SpecificEntropy pros "s for current guess in T";
  parameter SI.Temperature Tguess=1500 "initial temperature";
  Integer i "iteration counter";
  Real relerr "relative error in s";
  Real ds "Newton-error in s-direction";
  Real dT "Newton-step in T-direction";
  Boolean found "flag for iteration success";
algorithm
  i := 0;
  error := 0;
  T := Tguess;
  found := false;
  while ((i < IterationData.IMAX) and not found) loop
    g := Basic.g5(p, T);
    pros := data.RH2O*(g.tau*g.gtau - g.g);
    ds := pros - s;
    relerr := ds/s;
    if (abs(relerr) < relds) then
      found := true;
    end if;
    dT := ds*T/(-data.RH2O*g.tau*g.tau*g.gtautau);
    T := T - dT;
    i := i + 1;
  end while;
  if not found then
    error := 1;
  end if;
  assert(error <> 1, "error in inverse function tofps5: iteration failed");
end tofps5;
