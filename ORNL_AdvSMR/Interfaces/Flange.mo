within ORNL_AdvSMR.Interfaces;
connector Flange "Flange connector for water/steam flows"
  replaceable package Medium = Modelica.Media.Water.StandardWater
    constrainedby ORNL_AdvSMR.Media.Interfaces.PartialMedium "Medium model";
  flow Medium.MassFlowRate m_flow
    "Mass flow rate from the connection point into the component";
  Medium.AbsolutePressure p
    "Thermodynamic pressure in a defined point in the system";
  stream Medium.SpecificEnthalpy h_outflow
    "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
  stream Medium.MassFraction Xi_outflow[Medium.nXi]
    "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
  stream Medium.ExtraProperty C_outflow[Medium.nC]
    "Properties c_i/m close to the connection point if m_flow < 0";
  annotation (
    Documentation(info="<HTML>.
</HTML>", revisions="<html>
<ul>
<li><i>16 Dec 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Medium model added.</li>
<li><i>1 Oct 2003</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
    Diagram(graphics),
    Icon(graphics));
end Flange;
