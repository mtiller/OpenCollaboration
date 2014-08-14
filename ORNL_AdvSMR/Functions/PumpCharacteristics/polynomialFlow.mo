within ORNL_AdvSMR.Functions.PumpCharacteristics;
function polynomialFlow "Polynomial flow characteristic"
  extends baseFlow;
  input Modelica.SIunits.VolumeFlowRate q_nom[:]
    "Volume flow rate for N operating points (single pump)";
  input Modelica.SIunits.Height head_nom[:] "Pump head for N operating points";
  constant Modelica.SIunits.VolumeFlowRate q_eps=1e-6
    "Small coefficient to avoid numerical singularities";
protected
  parameter Integer N=size(q_nom, 1) "Number of nominal operating points";
  parameter Real q_nom_pow[N, N]={{q_nom[i]^(j - 1) for j in 1:N} for i in 1:N}
    "Rows: different operating points; columns: increasing powers";
  /* Linear system to determine the coefficients (example N=3):
  head_nom[1] = c[1] + q_nom[1]*c[2] + q_nom[1]^2*c[3];
  head_nom[2] = c[1] + q_nom[2]*c[2] + q_nom[2]^2*c[3];
  head_nom[3] = c[1] + q_nom[3]*c[2] + q_nom[3]^2*c[3];
  */
  parameter Real c[N]=Modelica.Math.Matrices.solve(q_nom_pow, head_nom)
    "Coefficients of polynomial head curve";
algorithm
  // Flow equation (example N=3): head = c[1] + q_flow*c[2] + q_flow^2*c[3];
  // Note: the implementation is numerically efficient only for low values of N
  head := sum((q_flow + q_eps)^(i - 1)*c[i] for i in 1:N);
end polynomialFlow;
