within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased.Polynomials_Temp;
function derivativeValue_der "time derivative of derivative of polynomial"
  extends Modelica.Icons.Function;
  input Real p[:]
    "Polynomial coefficients (p[1] is coefficient of highest power)";
  input Real u "Abszissa value";
  input Real du "delta of abszissa value";
  output Real dy
    "time-derivative of derivative of polynomial w.r.t. input variable at u";
protected
  Integer n=size(p, 1);
algorithm
  dy := secondDerivativeValue(p, u)*du;
end derivativeValue_der;
