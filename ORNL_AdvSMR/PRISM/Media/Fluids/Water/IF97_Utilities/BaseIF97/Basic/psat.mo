within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function psat "region 4 saturation pressure as a functionx of temperature"

  extends Modelica.Icons.Function;
  input SI.Temperature T "temperature (K)";
  output SI.Pressure p_sat "pressure";
protected
  Real[8] o "vector of auxiliary variables";
  Real Tlim=min(T, data.TCRIT);
algorithm
  assert(T >= 273.16,
    "IF97 medium function psat: input temperature (= " + String(
    triple.ptriple) + " K).\n" +
    "lower than the triple point temperature 273.16 K");
  o[1] := -650.17534844798 + Tlim;
  o[2] := 1/o[1];
  o[3] := -0.238555575678490*o[2];
  o[4] := o[3] + Tlim;
  o[5] := -4823.2657361591*o[4];
  o[6] := o[4]*o[4];
  o[7] := 14.9151086135300*o[6];
  o[8] := 405113.40542057 + o[5] + o[7];
  p_sat := 16.0e6*o[8]*o[8]*o[8]*o[8]*1/(3.2325550322333e6 -
    12020.8247024700*o[4] + 17.0738469400920*o[6] + (-4.0*(-724213.16703206
     + 1167.05214527670*o[4] + o[6])*o[8] + (-3.2325550322333e6
     + 12020.8247024700*o[4] - 17.0738469400920*o[6])^2.0)^0.5)
    ^4.0;
  annotation (derivative=psat_der);
end psat;
