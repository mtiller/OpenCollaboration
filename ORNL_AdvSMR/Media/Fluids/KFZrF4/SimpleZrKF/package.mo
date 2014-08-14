within ORNL_AdvSMR.Media.Fluids.KFZrF4;
package SimpleZrKF "Simplified KFZrF4 thermodynamic model"
/* For a new medium, make a copy of this package and remove
     the "partial" keyword from the package definition above.
     The statement below extends from PartialMedium and sets some
     package constants. Provide values for these constants
     that are appropriate for your medium model. Note that other
     constants (such as nX, nXi) are automatically defined by
     definitions given in the base class Interfaces.PartialMedium"
  */


extends Interfaces.PartialMedium(
  final mediumName="SimpleKFZrF4",
  final substanceNames={"ZrKF"},
  final singleState=false,
  final reducedX=true,
  final fixedX=true,
  Temperature(
    min=663.15,
    max=1723.15,
    start=663.15));

// Provide medium constants here
constant SpecificHeatCapacity cp_const=1051
  "Constant specific heat capacity at constant pressure";

/* The vector substanceNames is mandatory, as the number of
         substances is determined based on its size. Here we assume
         a single-component medium.
         singleState is true if u and d do not depend on pressure, but only
         on a thermal variable (temperature or enthalpy). Otherwise, set it
         to false.
         For a single-substance medium, just set reducedX and fixedX to true, and there's
         no need to bother about medium compositions at all. Otherwise, set
         final reducedX = true if the medium model has nS-1 independent mass
         fraction, or reducedX = false if the medium model has nS independent
         mass fractions (nS = number of substances).
         If a mixture has a fixed composition set fixedX=true, otherwise false.
         The modifiers for reducedX and fixedX should normally be final
         since the other equations are based on these values.

         It is also possible to redeclare the min, max, and start attributes of
         Medium types, defined in the base class Interfaces.PartialMedium
         (the example of Temperature is shown here). Min and max attributes
         should be set in accordance to the limits of validity of the medium
         model, while the start attribute should be a reasonable default value
         for the initialization of nonlinear solver iterations */

/* Provide an implementation of model BaseProperties,
     that is defined in PartialMedium. Select two independent
     variables from p, T, d, u, h. The other independent
     variables are the mass fractions "Xi", if there is more
     than one substance. Provide 3 equations to obtain the remaining
     variables as functions of the independent variables.
     It is also necessary to provide two additional equations to set
     the gas constant R and the molar mass MM of the medium.
     Finally, the thermodynamic state vector, defined in the base class
     Interfaces.PartialMedium.BaseProperties, should be set, according to
     its definition (see ThermodynamicState below).
     The computation of vector X[nX] from Xi[nXi] is already included in
     the base class Interfaces.PartialMedium.BaseProperties, so it should not
     be repeated here.
     The code fragment below is for a single-substance medium with
     p,T as independent variables.
  */


redeclare model extends BaseProperties(final standardOrderComponents=true)
  "Base properties of medium"

  equation
  d = 3658.28 - 0.887*T;
  h = cp_const*T;
  u = h - p/d;
  MM = 0.51422;
  R = 8.3144/MM;
  state.p = p;
  state.T = T;
  end BaseProperties;

/* Provide implementations of the following optional properties.
     If not available, delete the corresponding function.
     The record "ThermodynamicState" contains the input arguments
     of all the function and is defined together with the used
     type definitions in PartialMedium. The record most often contains two of the
     variables "p, T, d, h" (e.g., medium.T)
  */


redeclare replaceable record ThermodynamicState
  "a selction of variables that uniquely defines the thermodynamic state"
  AbsolutePressure p "Absolute pressure of medium";
  Temperature T "Temperature of medium";
  // SpecificEnthalpy h "Specific enthalpy of medium";
  annotation (Documentation(info="<html>

</html>"));
  end ThermodynamicState;


redeclare function extends dynamicViscosity "Return dynamic viscosity"
  algorithm
  eta := 1.59e-5*exp(3179/state.T)
    "dynamic viscosity; only as a function of temperature (K)";
  annotation (Documentation(info="<html>

</html>"));
  end dynamicViscosity;


redeclare function extends thermalConductivity "Return thermal conductivity"
  algorithm
  lambda := 0.32 "Thermal conductivity (W/m K)";
  annotation (Documentation(info="<html>

</html>"));
  end thermalConductivity;


redeclare function extends specificEntropy "Return specific entropy"
  algorithm
  s := 0;
  annotation (Documentation(info="<html>

</html>"));
  end specificEntropy;


redeclare function extends specificHeatCapacityCp
  "Return specific heat capacity at constant pressure"
  algorithm
  cp := 1051;
  annotation (Documentation(info="<html>

</html>"));
  end specificHeatCapacityCp;


redeclare function extends specificHeatCapacityCv
  "Return specific heat capacity at constant volume"
  algorithm
  cv := 1051;
  annotation (Documentation(info="<html>

</html>"));
  end specificHeatCapacityCv;


redeclare function extends isentropicExponent "Return isentropic exponent"
  extends Modelica.Icons.Function;
  algorithm
  gamma := 1.333;
  annotation (Documentation(info="<html>

</html>"));
  end isentropicExponent;


redeclare function extends velocityOfSound "Return velocity of sound"
  extends Modelica.Icons.Function;
  algorithm
  // a := 2500; // Constant average speed of sound within the operating range of temperature
  a := 1/sqrt(2.3e-11*exp(0.001*state.T)*(3658.28 - 0.887*state.T));
  // Temperature-dependent speed of sound
  annotation (Documentation(info="<html>

</html>"));
  end velocityOfSound;


annotation (Documentation(info="<HTML>
<p>
This package is a <b>template</b> for <b>new medium</b> models. For a new
medium model just make a copy of this package, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
</p>
</HTML>"));
end SimpleZrKF;
