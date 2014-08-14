within ORNL_AdvSMR.SmLMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function T_h "Compute temperature from specific enthalpy"
  input SpecificEnthalpy h "Specific enthalpy";
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
      y := h_T(f_nonlinear_data, x);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

algorithm
  T := Internal.solve(
                  h,
                  200,
                  6000,
                  1.0e5,
                  {1},
                  data);
end T_h;
