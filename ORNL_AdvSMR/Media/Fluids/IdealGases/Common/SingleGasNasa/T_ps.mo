within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function T_ps "Compute temperature from pressure and specific entropy"
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  output Temperature T "Temperature";

protected
  package Internal
    "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
    extends Modelica.Media.Common.OneNonLinearEquation;
    redeclare record extends f_nonlinear_Data
      "Data to be passed to non-linear function"
      extends DataRecord;
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear
    algorithm
      y := s0_T(f_nonlinear_data, x) - data.R*Modelica.Math.log(p/reference_p);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

algorithm
  T := Internal.solve(
    s,
    200,
    6000,
    p,
    {1},
    data);
end T_ps;
