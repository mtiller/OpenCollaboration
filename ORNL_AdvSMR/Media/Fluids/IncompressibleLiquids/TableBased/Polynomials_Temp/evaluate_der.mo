within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased.Polynomials_Temp;
function evaluate_der "Evaluate polynomial at a given abszissa value"
  extends Modelica.Icons.Function;
  input Real p[:]
    "Polynomial coefficients (p[1] is coefficient of highest power)";
  input Real u "Abszissa value";
  input Real du "Abszissa value";
  output Real dy "Value of polynomial at u";
protected
  Integer n=size(p, 1);
algorithm
  dy := p[1]*(n - 1);
  for j in 2:size(p, 1) - 1 loop
    dy := p[j]*(n - j) + u*dy;
  end for;
  dy := dy*du;
end evaluate_der;
