within ORNL_AdvSMR.Functions.FanCharacteristics.Utilities;
function quadraticFlowBladesCoeff
  extends Modelica.Icons.Function;
  input Real bladePos_nom[:];
  input Modelica.SIunits.VolumeFlowRate q_nom[3, :]
    "Volume flow rate for three operating points at N_pos blade positionings";
  input Modelica.SIunits.Height H_nom[3, :]
    "Specific work for three operating points at N_pos blade positionings";
  output Real c[3, size(bladePos_nom, 1)]
    "Coefficients of quadratic specific work characteristic";
protected
  Integer N_pos=size(bladePos_nom, 1);
  Real q_nom2[3];
algorithm
  for j in 1:N_pos loop
    q_nom2 := {q_nom[1, j]^2,q_nom[2, j]^2,q_nom[3, j]^2};
    c[:, j] := Modelica.Math.Matrices.solve([ones(3), q_nom[:, j], q_nom2],
      H_nom[:, j]);
  end for;
end quadraticFlowBladesCoeff;
