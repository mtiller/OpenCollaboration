within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function tofph5 "inverse iteration in region 5: (p,T) = f(p,h)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input SI.SpecificEnthalpy reldh "iteration accuracy";
  output SI.Temperature T "temperature (K)";
  output Integer error "error flag: iteration failed if different from 0";

protected
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  SI.SpecificEnthalpy proh "h for current guess in T";
  constant SI.Temperature Tguess=1500 "initial temperature";
  Integer i "iteration counter";
  Real relerr "relative error in h";
  Real dh "Newton-error in h-direction";
  Real dT "Newton-step in T-direction";
  Boolean found "flag for iteration success";
algorithm
  i := 0;
  error := 0;
  T := Tguess;
  found := false;
  while ((i < IterationData.IMAX) and not found) loop
    g := Basic.g5(p, T);
    proh := data.RH2O*T*g.tau*g.gtau;
    dh := proh - h;
    relerr := dh/h;
    if (abs(relerr) < reldh) then
      found := true;
    end if;
    dT := dh/(-data.RH2O*g.tau*g.tau*g.gtautau);
    T := T - dT;
    i := i + 1;
  end while;
  if not found then
    error := 1;
  end if;
  assert(error <> 1,
    "error in inverse function tofph5: iteration failed");
end tofph5;
