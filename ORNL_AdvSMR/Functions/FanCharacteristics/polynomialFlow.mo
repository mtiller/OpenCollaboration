within ORNL_AdvSMR.Functions.FanCharacteristics;
function polynomialFlow "Polynomial flow characteristic, fixed blades"
  extends baseFlow;
  input Modelica.SIunits.VolumeFlowRate q_nom[:]
    "Volume flow rate for N operating points (single fan)";
  input Modelica.SIunits.Height H_nom[:] "Specific work for N operating points";
protected
  parameter Integer N=size(q_nom, 1) "Number of nominal operating points";
  parameter Real q_nom_pow[N, N]={{q_nom[j]^(i - 1) for j in 1:N} for i in 1:N}
    "Rows: different operating points; columns: increasing powers";
  /* Linear system to determine the coefficients (example N=3):
  H_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  H_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  H_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
  parameter Real c[N]=Modelica.Math.Matrices.solve(q_nom_pow, H_nom)
    "Coefficients of polynomial specific work curve";
algorithm
  // Flow equation (example N=3): H = c[1] + q_flow*c[2] + q_flow^2*c[3];
  // Note: the implementation is numerically efficient only for low values of Na
  H := sum(q_flow^(i - 1)*c[i] for i in 1:N);
end polynomialFlow;
