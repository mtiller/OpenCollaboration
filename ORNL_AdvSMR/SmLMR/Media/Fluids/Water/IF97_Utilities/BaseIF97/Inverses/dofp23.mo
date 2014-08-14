within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function dofp23 "density at the boundary between regions 2 and 3"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.Density d "density";
protected
  SI.Temperature T;
  Real[13] o "vector of auxiliary variables";
  Real taug "auxiliary variable";
  Real pi "dimensionless pressure";
  Real gpi23
    "derivative of g w.r.t. pi on the boundary between regions 2 and 3";
algorithm
  pi := p/data.PSTAR2;
  T := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)
    ^0.5;
  o[1] := (-13.91883977887 + pi)^0.5;
  taug := -0.5 + 540.0/(572.54459862746 + 31.3220101646784*o[1]);
  o[2] := taug*taug;
  o[3] := o[2]*taug;
  o[4] := o[2]*o[2];
  o[5] := o[4]*o[4];
  o[6] := o[5]*o[5];
  o[7] := o[4]*o[5]*o[6]*taug;
  o[8] := o[4]*o[5]*taug;
  o[9] := o[2]*o[4]*o[5];
  o[10] := pi*pi;
  o[11] := o[10]*o[10];
  o[12] := o[4]*o[6]*taug;
  o[13] := o[6]*o[6];

  gpi23 := (1.0 + pi*(-0.0017731742473213 + taug*(-0.017834862292358
     + taug*(-0.045996013696365 + (-0.057581259083432 -
    0.05032527872793*o[3])*taug)) + pi*(taug*(-0.000066065283340406
     + (-0.0003789797503263 + o[2]*(-0.007878555448671 + o[3]*(
    -0.087594591301146 - 0.000053349095828174*o[7])))*taug) +
    pi*(6.1445213076927e-8 + (1.31612001853305e-6 + o[2]*(-0.00009683303171571
     + o[3]*(-0.0045101773626444 - 0.122004760687947*o[7])))*
    taug + pi*(taug*(-3.15389238237468e-9 + (5.116287140914e-8
     + 1.92901490874028e-6*taug)*taug) + pi*(
    0.0000114610381688305*o[2]*o[4]*taug + pi*(o[3]*(-1.00288598706366e-10
     + o[8]*(-0.012702883392813 - 143.374451604624*o[2]*o[6]*
    taug)) + pi*(-4.1341695026989e-17 + o[2]*o[5]*(-8.8352662293707e-6
     - 0.272627897050173*o[9])*taug + pi*(o[5]*(
    9.0049690883672e-11 - 65.8490727183984*o[4]*o[5]*o[6]) + pi
    *(1.78287415218792e-7*o[8] + pi*(o[4]*(1.0406965210174e-18
     + o[2]*(-1.0234747095929e-12 - 1.0018179379511e-8*o[4])*o[
    4]) + o[10]*o[11]*((-1.29412653835176e-9 + 1.71088510070544
    *o[12])*o[7] + o[10]*(-6.05920510335078*o[13]*o[5]*o[6]*
    taug + o[10]*(o[4]*o[6]*(1.78371690710842e-23 + o[2]*o[4]*o[
    5]*(6.1258633752464e-12 - 0.000084004935396416*o[8])*taug)
     + pi*(-1.24017662339842e-24*o[12] + pi*(
    0.0000832192847496054*o[13]*o[4]*o[6]*taug + pi*(o[2]*o[5]*
    o[6]*(1.75410265428146e-27 + (1.32995316841867e-15 -
    0.0000226487297378904*o[2]*o[6])*o[9])*pi -
    2.93678005497663e-14*o[13]*o[2]*o[4]*taug)))))))))))))))))/
    pi;
  d := p/(data.RH2O*T*pi*gpi23);
end dofp23;
