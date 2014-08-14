within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function d2n "density in region 2  as function of p and T"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  output SI.Density d "density";
protected
  Real pi "dimensionless pressure";
  Real tau "dimensionless temperature";
  Real tau2 "dimensionless temperature";
  Real gpi "dimensionless Gibbs-derivative w.r.t. pi";
  Real[12] o "auxiliary variables";
algorithm
  pi := p/data.PSTAR2;
  tau := data.TSTAR2/T;
  tau2 := tau - 0.5;
  o[1] := tau2*tau2;
  o[2] := o[1]*tau2;
  o[3] := o[1]*o[1];
  o[4] := o[3]*o[3];
  o[5] := o[4]*o[4];
  o[6] := o[3]*o[4]*o[5]*tau2;
  o[7] := o[3]*o[4]*tau2;
  o[8] := o[1]*o[3]*o[4];
  o[9] := pi*pi;
  o[10] := o[9]*o[9];
  o[11] := o[3]*o[5]*tau2;
  o[12] := o[5]*o[5];
  gpi := (1. + pi*(-0.0017731742473213 + tau2*(-0.017834862292358
     + tau2*(-0.045996013696365 + (-0.057581259083432 -
    0.05032527872793*o[2])*tau2)) + pi*(tau2*(-0.000066065283340406
     + (-0.0003789797503263 + o[1]*(-0.007878555448671 + o[2]*(
    -0.087594591301146 - 0.000053349095828174*o[6])))*tau2) +
    pi*(6.1445213076927e-8 + (1.31612001853305e-6 + o[1]*(-0.00009683303171571
     + o[2]*(-0.0045101773626444 - 0.122004760687947*o[6])))*
    tau2 + pi*(tau2*(-3.15389238237468e-9 + (5.116287140914e-8
     + 1.92901490874028e-6*tau2)*tau2) + pi*(
    0.0000114610381688305*o[1]*o[3]*tau2 + pi*(o[2]*(-1.00288598706366e-10
     + o[7]*(-0.012702883392813 - 143.374451604624*o[1]*o[5]*
    tau2)) + pi*(-4.1341695026989e-17 + o[1]*o[4]*(-8.8352662293707e-6
     - 0.272627897050173*o[8])*tau2 + pi*(o[4]*(
    9.0049690883672e-11 - 65.8490727183984*o[3]*o[4]*o[5]) + pi
    *(1.78287415218792e-7*o[7] + pi*(o[3]*(1.0406965210174e-18
     + o[1]*(-1.0234747095929e-12 - 1.0018179379511e-8*o[3])*o[
    3]) + o[10]*o[9]*((-1.29412653835176e-9 + 1.71088510070544*
    o[11])*o[6] + o[9]*(-6.05920510335078*o[12]*o[4]*o[5]*tau2
     + o[9]*(o[3]*o[5]*(1.78371690710842e-23 + o[1]*o[3]*o[4]*(
    6.1258633752464e-12 - 0.000084004935396416*o[7])*tau2) + pi
    *(-1.24017662339842e-24*o[11] + pi*(0.0000832192847496054*o[
    12]*o[3]*o[5]*tau2 + pi*(o[1]*o[4]*o[5]*(
    1.75410265428146e-27 + (1.32995316841867e-15 -
    0.0000226487297378904*o[1]*o[5])*o[8])*pi -
    2.93678005497663e-14*o[1]*o[12]*o[3]*tau2)))))))))))))))))/
    pi;
  d := p/(data.RH2O*T*pi*gpi);
end d2n;
