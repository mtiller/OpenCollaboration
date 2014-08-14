within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function dupper1ofT "density at upper pressure limit of region 1"
  extends Modelica.Icons.Function;
  input SI.Temperature T "temperature (K)";
  output SI.Density d "density";
protected
  Real tau "dimensionless temperature";
  Real[4] o "auxiliary variables";
algorithm
  tau := 1386.0/T;
  o[1] := tau*tau;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  o[4] := o[3]*o[3];
  d := 57.4756752485113/(2.24144616859917 + 40.9288231166229*o[
    1] + 106.47246463213*o[2] + 88.4481480270751*o[1]*o[2] +
    31.3207272417546*o[3] + 5.47811738891798*o[1]*o[3] +
    0.515626225030717*o[2]*o[3] + 0.0274905057899089*o[1]*o[2]*
    o[3] + 0.000853742979250503*o[4] + 0.0000155932210492199*o[
    1]*o[4] + 1.6621051480279e-7*o[2]*o[4] +
    1.00606771839976e-9*o[1]*o[2]*o[4] + 3.27598951831994e-12*o[
    3]*o[4] + 5.20162317530099e-15*o[1]*o[3]*o[4] +
    3.33501889800275e-18*o[2]*o[3]*o[4] + 5.50656040141221e-22*
    o[1]*o[2]*o[3]*o[4] - 13.5354267762204*tau -
    78.3629702507642*o[1]*tau - 109.374479648652*o[2]*tau -
    57.9035658513312*o[1]*o[2]*tau - 14.215347150565*o[3]*tau
     - 1.80906759985501*o[1]*o[3]*tau - 0.127542214693871*o[2]*
    o[3]*tau - 0.0051779458313163*o[1]*o[2]*o[3]*tau -
    0.000123304142684848*o[4]*tau - 1.72405791469972e-6*o[1]*o[
    4]*tau - 1.39155695911655e-8*o[2]*o[4]*tau -
    6.23333356847138e-11*o[1]*o[2]*o[4]*tau -
    1.44056015732082e-13*o[3]*o[4]*tau - 1.50201626932938e-16*o[
    1]*o[3]*o[4]*tau - 5.34588682252967e-20*o[2]*o[3]*o[4]*tau
     - 2.73712834080283e-24*o[1]*o[2]*o[3]*o[4]*tau);
end dupper1ofT;
