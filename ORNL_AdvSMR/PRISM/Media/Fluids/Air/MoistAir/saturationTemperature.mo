within ORNL_AdvSMR.PRISM.Media.Fluids.Air.MoistAir;
function saturationTemperature
  "Return saturation temperature of water as a function of (partial) pressure p"

  input SI.Pressure p "Pressure";
  input SI.Temperature T_min=200 "Lower boundary of solution";
  input SI.Temperature T_max=400 "Upper boundary of solution";
  output SI.Temperature T "Saturation temperature";

protected
  package Internal
    extends Common.OneNonLinearEquation;

    redeclare record extends f_nonlinear_Data
      // Define data to be passed to user function
    end f_nonlinear_Data;

    redeclare function extends f_nonlinear
    algorithm
      y := saturationPressure(x);
      // Compute the non-linear equation: y = f(x, Data)
    end f_nonlinear;

    // Dummy definition
    redeclare function extends solve
    end solve;
  end Internal;
algorithm
  T := Internal.solve(
    p,
    T_min,
    T_max);
  annotation (Documentation(info="<html>
 Computes saturation temperature from (partial) pressure via numerical inversion of the function <a href=\"modelica://Modelica.Media.Air.MoistAir.saturationPressure\">saturationPressure</a>. Therefore additional inputs are required (or the defaults are used) for upper and lower temperature bounds.
</html>"));
end saturationTemperature;
