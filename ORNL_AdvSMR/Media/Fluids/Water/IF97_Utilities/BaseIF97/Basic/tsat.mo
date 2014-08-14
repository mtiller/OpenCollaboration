within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function tsat "region 4 saturation temperature as a function of pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.Temperature t_sat "temperature";
protected
  Real pi "dimensionless pressure";
  Real[20] o "vector of auxiliary variables";
algorithm
  assert(p > triple.ptriple,
    "IF97 medium function tsat called with too low pressure\n" + "p = " +
    String(p) + " Pa <= " + String(triple.ptriple) +
    " Pa (triple point pressure)");
  //  assert(p <= data.PCRIT,
  //    "tsat: input pressure is higher than the critical point pressure");
  pi := min(p, data.PCRIT)*data.IPSTAR;
  o[1] := pi^0.25;
  o[2] := -3.2325550322333e6*o[1];
  o[3] := pi^0.5;
  o[4] := -724213.16703206*o[3];
  o[5] := 405113.40542057 + o[2] + o[4];
  o[6] := -17.0738469400920*o[1];
  o[7] := 14.9151086135300 + o[3] + o[6];
  o[8] := -4.0*o[5]*o[7];
  o[9] := 12020.8247024700*o[1];
  o[10] := 1167.05214527670*o[3];
  o[11] := -4823.2657361591 + o[10] + o[9];
  o[12] := o[11]*o[11];
  o[13] := o[12] + o[8];
  o[14] := o[13]^0.5;
  o[15] := -o[14];
  o[16] := -12020.8247024700*o[1];
  o[17] := -1167.05214527670*o[3];
  o[18] := 4823.2657361591 + o[15] + o[16] + o[17];
  o[19] := 1/o[18];
  o[20] := 2.0*o[19]*o[5];

  t_sat := 0.5*(650.17534844798 + o[20] - (-4.0*(-0.238555575678490 +
    1300.35069689596*o[19]*o[5]) + (650.17534844798 + o[20])^2.0)^0.5);
  annotation (derivative=tsat_der);
end tsat;
