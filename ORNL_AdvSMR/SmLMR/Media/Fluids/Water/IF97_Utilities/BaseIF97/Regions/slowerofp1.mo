within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function slowerofp1
  "explicit lower specific entropy limit of region 1 as function of pressure"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.SpecificEntropy s "specific entropy";
protected
  Real pi1 "dimensionless pressure";
  Real[3] o "vector of auxiliary variables";
algorithm
  pi1 := 7.1 - p/data.PSTAR1;
  assert(p > triple.ptriple,
    "IF97 medium function slowerofp1 called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  o[1] := pi1*pi1;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  s := 461.526*(-0.0268080988194267 + pi1*(0.00834795890110168
     + pi1*(-0.000486470924668433 + pi1*(-0.0000154902045012264
     + pi1*(-1.07631751351358e-6 + pi1*(9.64159058957115e-11 +
    o[1]*pi1*(4.81921078863103e-13 + o[2]*o[3]*pi1*(
    2.7879623870968e-34 + o[1]*(-4.22182957646226e-37 + o[1]*o[
    2]*(-7.44601427465175e-44 + pi1*(8.99540001407168e-45 + (-3.65230274480299e-46
     + 4.98464639687285e-48*pi1)*pi1)))))))))));
end slowerofp1;
