within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Basic;
function dptofT
  "derivative of pressure w.r.t. temperature along the saturation pressure curve"

  extends Modelica.Icons.Function;
  input SI.Temperature T "temperature (K)";
  output Real dpt(unit="Pa/K") "temperature derivative of pressure";
protected
  Real[31] o "vector of auxiliary variables";
  Real Tlim "temeprature limited to TCRIT";
algorithm
  Tlim := min(T, data.TCRIT);
  o[1] := -650.17534844798 + Tlim;
  o[2] := 1/o[1];
  o[3] := -0.238555575678490*o[2];
  o[4] := o[3] + Tlim;
  o[5] := -4823.2657361591*o[4];
  o[6] := o[4]*o[4];
  o[7] := 14.9151086135300*o[6];
  o[8] := 405113.40542057 + o[5] + o[7];
  o[9] := o[8]*o[8];
  o[10] := o[9]*o[9];
  o[11] := o[1]*o[1];
  o[12] := 1/o[11];
  o[13] := 0.238555575678490*o[12];
  o[14] := 1.00000000000000 + o[13];
  o[15] := 12020.8247024700*o[4];
  o[16] := -17.0738469400920*o[6];
  o[17] := -3.2325550322333e6 + o[15] + o[16];
  o[18] := -4823.2657361591*o[14];
  o[19] := 29.8302172270600*o[14]*o[4];
  o[20] := o[18] + o[19];
  o[21] := 1167.05214527670*o[4];
  o[22] := -724213.16703206 + o[21] + o[6];
  o[23] := o[17]*o[17];
  o[24] := -4.0000000000000*o[22]*o[8];
  o[25] := o[23] + o[24];
  o[26] := sqrt(o[25]);
  o[27] := -12020.8247024700*o[4];
  o[28] := 17.0738469400920*o[6];
  o[29] := 3.2325550322333e6 + o[26] + o[27] + o[28];
  o[30] := o[29]*o[29];
  o[31] := o[30]*o[30];
  dpt := 1e6*((-64.0*o[10]*(-12020.8247024700*o[14] + 34.147693880184*o[14]*o[4]
     + (0.5*(-4.0*o[20]*o[22] + 2.00000000000000*o[17]*(12020.8247024700*o[14]
     - 34.147693880184*o[14]*o[4]) - 4.0*(1167.05214527670*o[14] + 2.0*o[14]*o[
    4])*o[8]))/o[26]))/(o[29]*o[31]) + (64.*o[20]*o[8]*o[9])/o[31]);
end dptofT;
