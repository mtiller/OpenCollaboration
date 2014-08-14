within ORNL_AdvSMR.SmLMR.Media.Fluids.Air.MoistAir;
function T_phX
  "Return temperature as a function of pressure p, specific enthalpy h and composition X"
  input AbsolutePressure p "Pressure";
  input SpecificEnthalpy h "Specific enthalpy";
  input MassFraction[:] X "Mass fractions of composition";
  output Temperature T "Temperature";

protected
  package Internal
    "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
    extends Common.OneNonLinearEquation;
    redeclare record extends f_nonlinear_Data
      "Data to be passed to non-linear function"
      extends IdealGases.Common.DataRecord;
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear
    algorithm
      y := h_pTX(
            p,
            x,
            X);
    end f_nonlinear;

    // Dummy definition has to be added for current Dymola
    redeclare function extends solve
    end solve;
  end Internal;

algorithm
  T := Internal.solve(
    h,
    240,
    400,
    p,
    X[1:nXi],
    steam);
  annotation (Documentation(info="<html>
Temperature is computed from pressure, specific enthalpy and composition via numerical inversion of function <a href=\"modelica://Modelica.Media.Air.MoistAir.h_pTX\">h_pTX</a>.
</html>"));
end T_phX;
