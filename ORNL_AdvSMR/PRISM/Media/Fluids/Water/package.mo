within ORNL_AdvSMR.PRISM.Media.Fluids;
package Water "Medium models for water"


extends Modelica.Icons.MaterialPropertiesPackage;
constant Interfaces.PartialTwoPhaseMedium.FluidConstants[1] waterConstants(
  each chemicalFormula="H2O",
  each structureFormula="H2O",
  each casRegistryNumber="7732-18-5",
  each iupacName="oxidane",
  each molarMass=0.018015268,
  each criticalTemperature=647.096,
  each criticalPressure=22064.0e3,
  each criticalMolarVolume=1/322.0*0.018015268,
  each normalBoilingPoint=373.124,
  each meltingPoint=273.15,
  each triplePointTemperature=273.16,
  each triplePointPressure=611.657,
  each acentricFactor=0.344,
  each dipoleMoment=1.8,
  each hasCriticalData=true);

constant Interfaces.PartialMedium.FluidConstants[1] simpleWaterConstants(
  each chemicalFormula="H2O",
  each structureFormula="H2O",
  each casRegistryNumber="7732-18-5",
  each iupacName="oxidane",
  each molarMass=0.018015268);


annotation (Documentation(info="<html>
<p>This package contains different medium models for water:</p>
<ul>
<li><b>ConstantPropertyLiquidWater</b><br>
    Simple liquid water medium (incompressible, constant data).</li>
<li><b>IdealSteam</b><br>
    Steam water medium as ideal gas from Media.IdealGases.SingleGases.H2O</li>
<li><b>WaterIF97 derived models</b><br>
    High precision water model according to the IAPWS/IF97 standard
    (liquid, steam, two phase region). Models with different independent
    variables are provided as well as models valid only
    for particular regions. The <b>WaterIF97_ph</b> model is valid
    in all regions and is the recommended one to use.</li>
</ul>
<h4>Overview of WaterIF97 derived water models</h4>
<p>
The WaterIF97 models calculate medium properties
for water in the <b>liquid</b>, <b>gas</b> and <b>two phase</b> regions
according to the IAPWS/IF97 standard, i.e., the accepted industrial standard
and best compromise between accuracy and computation time.
It has been part of the ThermoFluid Modelica library and been extended,
reorganized and documented to become part of the Modelica Standard library.</p>
<p>An important feature that distinguishes this implementation of the IF97 steam property standard
is that this implementation has been explicitly designed to work well in dynamic simulations. Computational
performance has been of high importance. This means that there often exist several ways to get the same result
from different functions if one of the functions is called often but can be optimized for that purpose.
</p>
<p>Three variable pairs can be the independent variables of the model:
</p>
<ol>
<li>Pressure <b>p</b> and specific enthalpy <b>h</b> are
    the most natural choice for general applications.
    This is the recommended choice for most general purpose
    applications, in particular for power plants.</li>
<li>Pressure <b>p</b> and temperature <b>T</b> are the most natural
    choice for applications where water is always in the same phase,
    both for liquid water and steam.</li>
<li>Density <b>d</b> and temperature <b>T</b> are explicit
    variables of the Helmholtz function in the near-critical
    region and can be the best choice for applications with
    super-critical or near-critial states.</li>
</ol>
<p>
The following quantities are always computed in Medium.Baseproperties:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Variable</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">T</td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">temperature</td></tr>
  <tr><td valign=\"top\">u</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific internal energy</b></td></tr>
  <tr><td valign=\"top\">d</td>
      <td valign=\"top\">kg/m^3</td>
      <td valign=\"top\">density</td></tr>
  <tr><td valign=\"top\">p</td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">pressure</td></tr>
  <tr><td valign=\"top\">h</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">specific enthalpy</b></td></tr>
</table>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the following functions:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.dynamicViscosity(medium.state)</b></td>
      <td valign=\"top\">Pa.s</td>
      <td valign=\"top\">dynamic viscosity</td></tr>
  <tr><td valign=\"top\">Medium.thermalConductivity(medium.state)</td>
      <td valign=\"top\">W/(m.K)</td>
      <td valign=\"top\">thermal conductivity</td></tr>
  <tr><td valign=\"top\">Medium.prandtlNumber(medium.state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">Prandtl number</td></tr>
  <tr><td valign=\"top\">Medium.specificEntropy(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific entropy</td></tr>
  <tr><td valign=\"top\">Medium.heatCapacity_cp(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.heatCapacity_cv(medium.state)</td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">specific heat capacity at constant density</td></tr>
  <tr><td valign=\"top\">Medium.isentropicExponent(medium.state)</td>
      <td valign=\"top\">1</td>
      <td valign=\"top\">isentropic exponent</td></tr>
  <tr><td valign=\"top\">Medium.isentropicEnthalpy(pressure, medium.state)</td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">isentropic enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.velocityOfSound(medium.state)</td>
      <td valign=\"top\">m/s</td>
      <td valign=\"top\">velocity of sound</td></tr>
  <tr><td valign=\"top\">Medium.isobaricExpansionCoefficient(medium.state)</td>
      <td valign=\"top\">1/K</td>
      <td valign=\"top\">isobaric expansion coefficient</td></tr>
  <tr><td valign=\"top\">Medium.isothermalCompressibility(medium.state)</td>
      <td valign=\"top\">1/Pa</td>
      <td valign=\"top\">isothermal compressibility</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_h(medium.state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td valign=\"top\">Medium.density_derh_p(medium.state)</td>
      <td valign=\"top\">kg2/(m3.J)</td>
      <td valign=\"top\">derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derp_T(medium.state)</td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">derivative of density by pressure at constant temperature</td></tr>
  <tr><td valign=\"top\">Medium.density_derT_p(medium.state)</td>
      <td valign=\"top\">kg/(m3.K)</td>
      <td valign=\"top\">derivative of density by temperature at constant pressure</td></tr>
  <tr><td valign=\"top\">Medium.density_derX(medium.state)</td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">derivative of density by mass fraction</td></tr>
  <tr><td valign=\"top\">Medium.molarMass(medium.state)</td>
      <td valign=\"top\">kg/mol</td>
      <td valign=\"top\">molar mass</td></tr>
</table>
<p>More details are given in
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
Modelica.Media.UsersGuide.MediumUsage.OptionalProperties</a>.

Many additional optional functions are defined to compute properties of
saturated media, either liquid (bubble point) or vapour (dew point).
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation temperature.
With reference to a model defining a pressure p, a temperature T, and a
SaturationProperties record sat, the following functions are provided:
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Function call</b></td>
      <td valign=\"top\"><b>Unit</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>
  <tr><td valign=\"top\">Medium.saturationPressure(T)</b></td>
      <td valign=\"top\">Pa</td>
      <td valign=\"top\">Saturation pressure at temperature T</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature(p)</b></td>
      <td valign=\"top\">K</td>
      <td valign=\"top\">Saturation temperature at pressure p</td></tr>
  <tr><td valign=\"top\">Medium.saturationTemperature_derp(p)</b></td>
      <td valign=\"top\">K/Pa</td>
      <td valign=\"top\">Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.bubbleEnthalpy(sat)</b></td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">Specific enthalpy at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewEnthalpy(sat)</b></td>
      <td valign=\"top\">J/kg</td>
      <td valign=\"top\">Specific enthalpy at dew point</td></tr>
  <tr><td valign=\"top\">Medium.bubbleEntropy(sat)</b></td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">Specific entropy at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewEntropy(sat)</b></td>
      <td valign=\"top\">J/(kg.K)</td>
      <td valign=\"top\">Specific entropy at dew point</td></tr>
  <tr><td valign=\"top\">Medium.bubbleDensity(sat)</b></td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">Density at bubble point</td></tr>
  <tr><td valign=\"top\">Medium.dewDensity(sat)</b></td>
      <td valign=\"top\">kg/m3</td>
      <td valign=\"top\">Density at dew point</td></tr>
  <tr><td valign=\"top\">Medium.dBubbleDensity_dPressure(sat)</b></td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">Derivative of density at bubble point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dDewDensity_dPressure(sat)</b></td>
      <td valign=\"top\">kg/(m3.Pa)</td>
      <td valign=\"top\">Derivative of density at dew point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dBubbleEnthalpy_dPressure(sat)</b></td>
      <td valign=\"top\">J/(kg.Pa)</td>
      <td valign=\"top\">Derivative of specific enthalpy at bubble point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.dDewEnthalpy_dPressure(sat)</b></td>
      <td valign=\"top\">J/(kg.Pa)</td>
      <td valign=\"top\">Derivative of specific enthalpy at dew point with respect to pressure</td></tr>
  <tr><td valign=\"top\">Medium.surfaceTension(sat)</b></td>
      <td valign=\"top\">N/m</td>
      <td valign=\"top\">Surface tension between liquid and vapour phase</td></tr>
</table>

<p>Details on usage and some examples are given in:
<a href=\"modelica://Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
Modelica.Media.UsersGuide.MediumUsage.TwoPhase</a>.
</p>

<p>Many further properties can be computed. Using the well-known Bridgman's Tables,
all first partial derivatives of the standard thermodynamic variables can be computed easily.
</p>
<p>
The documentation of the IAPWS/IF97 steam properties can be freely
distributed with computer implementations and are included here
(in directory Modelica/Resources/Documentation/Media/Water/IF97documentation):
<ul>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/IF97.pdf\">IF97.pdf</a> The standards document for the main part of the IF97.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/Back3.pdf\">Back3.pdf</a> The backwards equations for region 3.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/crits.pdf\">crits.pdf</a> The critical point data.</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/meltsub.pdf\">meltsub.pdf</a> The melting- and sublimation line formulation (not implemented)</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/surf.pdf\">surf.pdf</a> The surface tension standard definition</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/thcond.pdf\">thcond.pdf</a> The thermal conductivity standard definition</li>
<li><a href=\"modelica://Modelica/Resources/Documentation/Media/Water/IF97documentation/visc.pdf\">visc.pdf</a> The viscosity standard definition</li>
</ul>
</html>"));
end Water;
