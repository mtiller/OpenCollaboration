within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function pofdt125 "inverse iteration in region 1,2 and 5: p = g(d,T)"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature (K)";
  input SI.Pressure reldd "relative iteration accuracy of density";
  input Integer region
    "region in IAPWS/IF97 in which inverse should be calculated";
  output SI.Pressure p "pressure";
  output Integer error "error flag: iteration failed if different from 0";
protected
  Integer i "counter for while-loop";
  Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
  Boolean found "flag if iteration has been successful";
  Real dd "difference between density for  guessed p and the current density";
  Real delp "step in p in Newton-iteration";
  Real relerr "relative error in d";
  SI.Pressure pguess1=1.0e6 "initial pressure guess in region 1";
  SI.Pressure pguess2 "initial pressure guess in region 2";
  constant SI.Pressure pguess5=0.5e6 "initial pressure guess in region 5";
algorithm
  i := 0;
  error := 0;
  pguess2 := 42800*d;
  found := false;
  if region == 1 then
    p := pguess1;
  elseif region == 2 then
    p := pguess2;
  else
    p := pguess5;
  end if;
  while ((i < IterationData.IMAX) and not found) loop
    if region == 1 then
      g := Basic.g1(p, T);
    elseif region == 2 then
      g := Basic.g2(p, T);
    else
      g := Basic.g5(p, T);
    end if;
    dd := p/(data.RH2O*T*g.pi*g.gpi) - d;
    relerr := dd/d;
    if (abs(relerr) < reldd) then
      found := true;
    end if;
    delp := dd*(-p*p/(d*d*data.RH2O*T*g.pi*g.pi*g.gpipi));
    p := p - delp;
    i := i + 1;
    if not found then
      if p < triple.ptriple then
        p := 2.0*triple.ptriple;
      end if;
      if p > data.PLIMIT1 then
        p := 0.95*data.PLIMIT1;
      end if;
    end if;
  end while;

  // print("i = " + i2s(i) + ", p = " + r2s(p/1.0e5) + ", delp = " + r2s(delp*1.0e-5) + "\n");
  if not found then
    error := 1;
  end if;
  assert(error <> 1,
    "error in inverse function pofdt125: iteration failed");
end pofdt125;
