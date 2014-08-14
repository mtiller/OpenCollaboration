within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function g5 "base function for region 5: g(p,T)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output Common.GibbsDerivs g
    "dimensionless Gibbs funcion and dervatives w.r.t. pi and tau";
protected
  Real[11] o "vector of auxiliary variables";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function g5 called with too low pressure\n" +
    "p = " + String(p) + " Pa <= " + String(triple.ptriple) +
    " Pa (triple point pressure)");
  assert(p <= data.PLIMIT5,
    "IF97 medium function g5: input pressure (= " + String(p)
     + " Pa) is higher than 10 Mpa in region 5");
  assert(T <= 2273.15,
    "IF97 medium function g5: input temperature (= " + String(T)
     + " K) is higher than limit of 2273.15K in region 5");
  g.p := p;
  g.T := T;
  g.R := data.RH2O;
  g.pi := p/data.PSTAR5;
  g.tau := data.TSTAR5/T;
  o[1] := g.tau*g.tau;
  o[2] := -0.0045942820899910*o[1];
  o[3] := 0.00217746787145710 + o[2];
  o[4] := o[3]*g.tau;
  o[5] := o[1]*g.tau;
  o[6] := o[1]*o[1];
  o[7] := o[6]*o[6];
  o[8] := o[7]*g.tau;
  o[9] := -7.9449656719138e-6*o[8];
  o[10] := g.pi*g.pi;
  o[11] := -0.0137828462699730*o[1];

  g.g := g.pi*(-0.000125631835895920 + o[4] + g.pi*(-3.9724828359569e-6
    *o[8] + 1.29192282897840e-7*o[5]*g.pi)) + (-0.0248051489334660
     + g.tau*(0.36901534980333 + g.tau*(-3.11613182139250 + g.tau
    *(-13.1799836742010 + (6.8540841634434 - 0.32961626538917*g.tau)
    *g.tau + Modelica.Math.log(g.pi)))))/o[5];

  g.gpi := (1.0 + g.pi*(-0.000125631835895920 + o[4] + g.pi*(o[
    9] + 3.8757684869352e-7*o[5]*g.pi)))/g.pi;

  g.gpipi := (-1.00000000000000 + o[10]*(o[9] +
    7.7515369738704e-7*o[5]*g.pi))/o[10];

  g.gtau := g.pi*(0.00217746787145710 + o[11] + g.pi*(-0.000035752345523612
    *o[7] + 3.8757684869352e-7*o[1]*g.pi)) + (0.074415446800398
     + g.tau*(-0.73803069960666 + (3.11613182139250 + o[1]*(
    6.8540841634434 - 0.65923253077834*g.tau))*g.tau))/o[6];

  g.gtautau := (-0.297661787201592 + g.tau*(2.21409209881998 +
    (-6.2322636427850 - 0.65923253077834*o[5])*g.tau))/(o[6]*g.tau)
     + g.pi*(-0.0275656925399460*g.tau + g.pi*(-0.000286018764188897
    *o[1]*o[6]*g.tau + 7.7515369738704e-7*g.pi*g.tau));

  g.gtaupi := 0.00217746787145710 + o[11] + g.pi*(-0.000071504691047224
    *o[7] + 1.16273054608056e-6*o[1]*g.pi);
end g5;
