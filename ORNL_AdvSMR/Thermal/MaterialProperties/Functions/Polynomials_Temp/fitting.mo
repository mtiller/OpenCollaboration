within ORNL_AdvSMR.Thermal.MaterialProperties.Functions.Polynomials_Temp;
function fitting
  "Computes the coefficients of a polynomial that fits a set of data points in a least-squares sense"
  extends Modelica.Icons.Function;
  input Real u[:] "Abscissa data values";
  input Real y[size(u, 1)] "Ordinate data values";
  input Integer n(min=1)
    "Order of desired polynomial that fits the data points (u,y)";
  output Real p[n + 1]
    "Polynomial coefficients of polynomial that fits the date points";
protected
  Real V[size(u, 1), n + 1] "Vandermonde matrix";
algorithm
  // Construct Vandermonde matrix
  V[:, n + 1] := ones(size(u, 1));
  for j in n:-1:1 loop
    V[:, j] := {u[i]*V[i, j + 1] for i in 1:size(u, 1)};
  end for;

  // Solve least squares problem
  p := Modelica.Math.Matrices.leastSquares(V, y);
end fitting;
