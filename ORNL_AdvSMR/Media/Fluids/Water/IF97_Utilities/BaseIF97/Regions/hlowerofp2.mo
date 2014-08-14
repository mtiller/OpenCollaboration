within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function hlowerofp2
  "explicit lower specific enthalpy limit of region 2 as function of pressure (meets region 4 saturation pressure curve at 623.15 K)"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real pi "dimensionless pressure";
  Real q1 "auxiliary variable";
  Real q2 "auxiliary variable";
  Real[18] o "vector of auxiliary variables";
algorithm
  pi := p/data.PSTAR2;
  assert(p > triple.ptriple,
    "IF97 medium function hlowerofp2 called with too low pressure\n" + "p = "
     + String(p) + " Pa <= " + String(triple.ptriple) +
    " Pa (triple point pressure)");
  q1 := 572.54459862746 + 31.3220101646784*(-13.91883977887 + pi)^0.5;
  q2 := -0.5 + 540./q1;
  o[1] := q1*q1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  o[4] := pi*pi;
  o[5] := o[4]*o[4];
  o[6] := q2*q2;
  o[7] := o[6]*o[6];
  o[8] := o[6]*o[7];
  o[9] := o[5]*o[5];
  o[10] := o[7]*o[7];
  o[11] := o[9]*o[9];
  o[12] := o[10]*o[10];
  o[13] := o[12]*o[12];
  o[14] := o[7]*q2;
  o[15] := o[6]*q2;
  o[16] := o[10]*o[6];
  o[17] := o[13]*o[6];
  o[18] := o[13]*o[6]*q2;
  h := (4.63697573303507e9 + 3.74686560065793*o[2] + 3.57966647812489e-6*o[1]*o[
    2] + 2.81881548488163e-13*o[3] - 7.64652332452145e7*q1 -
    0.00450789338787835*o[2]*q1 - 1.55131504410292e-9*o[1]*o[2]*q1 + o[1]*(
    2.51383707870341e6 - 4.78198198764471e6*o[10]*o[11]*o[12]*o[13]*o[4] +
    49.9651389369988*o[11]*o[12]*o[13]*o[4]*o[5]*o[7] + o[15]*o[4]*(
    1.03746636552761e-13 - 0.00349547959376899*o[16] - 2.55074501962569e-7*o[8])
    *o[9] + (-242662.235426958*o[10]*o[12] - 3.46022402653609*o[16])*o[4]*o[5]*
    pi + o[4]*(0.109336249381227 - 2248.08924686956*o[14] - 354742.725841972*o[
    17] - 24.1331193696374*o[6])*pi - 3.09081828396912e-19*o[11]*o[12]*o[5]*o[7]
    *pi - 1.24107527851371e-8*o[11]*o[13]*o[4]*o[5]*o[6]*o[7]*pi +
    3.99891272904219*o[5]*o[8]*pi + 0.0641817365250892*o[10]*o[7]*o[9]*pi + pi*
    (-4444.87643334512 - 75253.6156722047*o[14] - 43051.9020511789*o[6] -
    22926.6247146068*q2) + o[4]*(-8.23252840892034 - 3927.0508365636*o[15] -
    239.325789467604*o[18] - 76407.3727417716*o[8] - 94.4508644545118*q2) +
    0.360567666582363*o[5]*(-0.0161221195808321 + q2)*(0.0338039844460968 + q2)
     + o[11]*(-0.000584580992538624*o[10]*o[12]*o[7] + 1.33248030241755e6*o[12]
    *o[13]*q2) + o[9]*(-7.38502736990986e7*o[18] + 0.0000224425477627799*o[6]*o[
    7]*q2) + o[4]*o[5]*(-2.08438767026518e8*o[17] - 0.0000124971648677697*o[6]
     - 8442.30378348203*o[10]*o[6]*o[7]*q2) + o[11]*o[9]*(4.73594929247646e-22*
    o[10]*o[12]*q2 - 13.6411358215175*o[10]*o[12]*o[13]*q2 +
    5.52427169406836e-10*o[13]*o[6]*o[7]*q2) + o[11]*o[5]*(2.67174673301715e-6*
    o[17] + 4.44545133805865e-18*o[12]*o[6]*q2 - 50.2465185106411*o[10]*o[13]*o[
    6]*o[7]*q2)))/o[1];
end hlowerofp2;
