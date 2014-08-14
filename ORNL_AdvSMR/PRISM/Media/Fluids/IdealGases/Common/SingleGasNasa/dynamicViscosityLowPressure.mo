within ORNL_AdvSMR.PRISM.Media.Fluids.IdealGases.Common.SingleGasNasa;
function dynamicViscosityLowPressure "Dynamic viscosity of low pressure gases"
  extends Modelica.Icons.Function;
  input SI.Temp_K T "Gas temperature";
  input SI.Temp_K Tc "Critical temperature of gas";
  input SI.MolarMass M "Molar mass of gas";
  input SI.MolarVolume Vc "Critical molar volume of gas";
  input Real w "Acentric factor of gas";
  input DipoleMoment mu "Dipole moment of gas molecule";
  input Real k=0.0 "Special correction for highly polar substances";
  output SI.DynamicViscosity eta "Dynamic viscosity of gas";
protected
  parameter Real Const1_SI=40.785*10^(-9.5)
    "Constant in formula for eta converted to SI units";
  parameter Real Const2_SI=131.3/1000.0
    "Constant in formula for mur converted to SI units";
  Real mur=Const2_SI*mu/sqrt(Vc*Tc)
    "Dimensionless dipole moment of gas molecule";
  Real Fc=1 - 0.2756*w + 0.059035*mur^4 + k
    "Factor to account for molecular shape and polarities of gas";
  Real Tstar "Dimensionless temperature defined by equation below";
  Real Ov "Viscosity collision integral for the gas";

algorithm
  Tstar := 1.2593*T/Tc;
  Ov := 1.16145*Tstar^(-0.14874) + 0.52487*exp(-0.7732*Tstar) +
    2.16178*exp(-2.43787*Tstar);
  eta := Const1_SI*Fc*sqrt(M*T)/(Vc^(2/3)*Ov);
  annotation (smoothOrder=2, Documentation(info="<html>
<p>
The used formula are based on the method of Chung et al (1984, 1988) referred to in ref [1] chapter 9.
The formula 9-4.10 is the one being used. The Formula is given in non-SI units, the follwong onversion constants were used to
transform the formula to SI units:
</p>

<ul>
<li> <b>Const1_SI:</b> The factor 10^(-9.5) =10^(-2.5)*1e-7 where the
     factor 10^(-2.5) originates from the conversion of g/mol->kg/mol + cm^3/mol->m^3/mol
      and the factor 1e-7 is due to conversionfrom microPoise->Pa.s.</li>
<li>  <b>Const2_SI:</b> The factor 1/3.335641e-27 = 1e-3/3.335641e-30
      where the factor 3.335641e-30 comes from debye->C.m and
      1e-3 is due to conversion from cm^3/mol->m^3/mol</li>
</ul>

<h4>References:</h4>
<p>
[1] Bruce E. Poling, John E. Prausnitz, John P. O'Connell, \"The Properties of Gases and Liquids\" 5th Ed. Mc Graw Hill.
</p>

<h4>Author</h4>
<p>T. Skoglund, Lund, Sweden, 2004-08-31</p>

</html>"));
end dynamicViscosityLowPressure;
