within ORNL_AdvSMR.Media.EquationsOfState.Interfaces;
package Liquids "Base class for implementing liquid media, assumes state variables pTX"
import ORNL_AdvSMR.Media.Interfaces.State.Units;
constant ORNL_AdvSMR.Media.Interfaces.Types.Compressibility CompressibilityType
  "Enumeration defining the compressibility assumption";
constant Boolean analyticInverseTfromh=false
  "If true, an analytic inverse is available to compute temperature, given specific enthalpy";


replaceable partial function h_pTX
  "Return specific enthalpy as a function of pressure p, temperature T and composition X"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  output Units.SpecificEnthalpy h "Specific enthalpy";
  end h_pTX;


replaceable partial function T_phX
  "Return temperature as a function of pressure p, specific enthalpy h and composition X"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.SpecificEnthalpy h "Specific enthalpy";
  input Units.MassFraction[:] X "Mass fractions of composition";
  output Units.Temperature T "Temperature";
  end T_phX;


replaceable partial function s_pTX
  "Compute specifc entropy (gas parts only!) of moist gases"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  output Units.SpecificEntropy s "Specific entropy";
  end s_pTX;


replaceable partial function T_psX
  "Return temperature as a function of pressure p, specific entropy s and composition X"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.SpecificEntropy s "Specific entropy";
  input Units.MassFraction[:] X "Mass fractions of composition";
  output Units.Temperature T "Temperature";
  end T_psX;


replaceable partial function d_pTX
  "Compute density as function of pressure, temperature and composition"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  output Units.Density d "Density";
  end d_pTX;


replaceable partial function v_pTX
  "Compute specific voume as function of pressure, temperature and composition"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions of moist air";
  output Units.SpecificVolume v "Specific volume";
  end v_pTX;


replaceable partial function cp_pTX
  "Return specific heat capacity as a function of pressure p, temperature T and composition X"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  output Units.SpecificHeatCapacity cp "Specific heat capacity";
  end cp_pTX;


replaceable partial function beta_pTX
  "Return specific volumetric expansion coefficient as a function of pressure p, temperature T and composition"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions";
  output Units.VolumetricExpansionCoefficient beta
    "Volumetric expansion coefficient";
  end beta_pTX;


replaceable partial function kappa_pTX
  "Return specific Isothermal compressibility as a function of pressure p, temperature T and composition"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions ";
  output Units.IsothermalCompressibility kappa "Isothermal compressibility";
  end kappa_pTX;


replaceable partial function his_pTX_p2
  "Compute isentropic enthalpy from upstream conditions and downstream pressure"
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction[:] X "Mass fraction";
  input Units.AbsolutePressure p2 "Pressure";
  output Units.SpecificEnthalpy his "Specific enthalpy";
  end his_pTX_p2;


replaceable partial function vaporPressure_pTX
  "function that returns the vaporPressure given the temperature"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction[:] X "Mass fractions of composition";
  output Units.AbsolutePressure pVap "Vapor pressure";
  end vaporPressure_pTX;


replaceable partial function dddp_pTX
  "Compute partial derivative of density wrt. pressure"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions";
  output Units.DerDensityByPressure dddp;
  end dddp_pTX;


replaceable partial function dddT_pTX
  "Compute partial derivative of density wrt. temperature"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions";
  output Units.DerDensityByTemperature dddT;
  end dddT_pTX;


replaceable partial function dddX_pTX
  "Compute partial derivative of density wrt. mass fraction"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions";
  output Units.DerDensityByComposition[size(X, 1)] dddX;
  end dddX_pTX;


replaceable partial function dudp_pTX
  "Compute specific energy derivative wrt. pressure"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions";
  output Units.DerSpecificEnergyByPressure dudp;
  end dudp_pTX;


replaceable partial function dudT_pTX
  "Compute specific energy derivative wrt. temperature"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions";
  output Units.DerSpecificEnergyByTemperature dudT;
  end dudT_pTX;


replaceable partial function dudX_pTX
  "Compute specific energy derivative wrt. mass fraction"
  extends Modelica.Icons.Function;
  input Units.AbsolutePressure p "Pressure";
  input Units.Temperature T "Temperature";
  input Units.MassFraction X[:] "Mass fractions";
  output Real[size(X, 1)] dudX;
  end dudX_pTX;


annotation (Documentation(info="<html>
<p>Interface class for liquid implementations under the assumptions:</p>
<p><ul>
<li>State variables are pressure, temperature and mass fraction</li>
<li>Partial derivatives with constant specific enthalpy and derivatives wrt. specific enthalpy are not defined
</ul></p>
</html>"));
end Liquids;
