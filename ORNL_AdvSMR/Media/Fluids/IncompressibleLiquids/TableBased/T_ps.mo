within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function T_ps "Compute temperature from pressure and specific enthalpy"
  input AbsolutePressure p "pressure";
  input SpecificEntropy s "specific entropy";
  output Temperature T "temperature";
protected
  package Internal
    "Solve h(T) for T with given h (use only indirectly via temperature_phX)"
    extends Modelica.Media.Common.OneNonLinearEquation;

    redeclare record extends f_nonlinear_Data
      "superfluous record, fix later when better structure of inverse functions exists"
      constant Real[5] dummy={1,2,3,4,5};
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear "p is smuggled in via vector"
    algorithm
      y := s_T(x);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;
algorithm
  T := Internal.solve(
    s,
    T_min,
    T_max,
    p,
    {1},
    Internal.f_nonlinear_Data());
end T_ps;
