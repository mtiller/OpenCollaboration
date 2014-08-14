within ORNL_AdvSMR.Thermal;
model CylinderFourier
  "Thermal model of a hollow cylinder by Fourier's equation - 1 axial node and Nr radial nodes"
  import Modelica.SIunits.*;
  import ORNL_AdvSMR.Choices.CylinderFourier.NodeDistribution;
  extends ORNL_AdvSMR.Icons.MetalWall;

  replaceable model MaterialModel = MaterialProperties.Metals.StandardSteel
    constrainedby MaterialProperties.Interfaces.PartialMaterial "Metal model";
  parameter Integer Nr=2 "Number of radial nodes";
  parameter NodeDistribution nodeDistribution=ORNL_AdvSMR.Choices.CylinderFourier.NodeDistribution.uniform
    "Node distribution";
  parameter Length rint "Internal radius";
  parameter Length rext "External radius";
  parameter Temperature Tstartint=300
    "Temperature start value at rint (first node)"
    annotation (Dialog(tab="Initialisation"));
  parameter Temperature Tstartext=300
    "Temperature start value at rext (last node)"
    annotation (Dialog(tab="Initialisation"));
  parameter ORNL_AdvSMR.Choices.Init.Options initOpt=ORNL_AdvSMR.Choices.Init.Options.noInit
    "Initialisation option" annotation (Dialog(tab="Initialisation"));

  Length r[Nr](fixed=false) "Node radii";
protected
  Length r1_2[Nr - 1](fixed=false) "Slice mean radii";
  Length r_lin[Nr](fixed=false) "Linearly distributed radii";
  Real A[Nr](fixed=false);
  Real B[Nr](fixed=false);
  Real C[Nr](fixed=false);

public
  Temperature T[Nr](start=linspace(
        Tstartint,
        Tstartext,
        Nr)) "Nodal temperatures";
  Temperature Tm "Mean temperature";
  MaterialModel metal[Nr] "Metal properties at the nodes";

  ORNL_AdvSMR.Thermal.DHT internalBoundary(final N=1) annotation (Placement(
        transformation(extent={{-20,20},{20,40}}, rotation=0)));
  ORNL_AdvSMR.Thermal.DHT externalBoundary(final N=1) annotation (Placement(
        transformation(extent={{-20,-40},{20,-20}}, rotation=0)));

equation
  // Generation of the temperature node distribution
  r_lin = linspace(
    rint,
    rext,
    Nr) "Linearly distributed node radii";
  for i in 1:Nr loop
    if nodeDistribution == NodeDistribution.uniform then
      r[i] = r_lin[i] "Uniform distribution of node radii";
    elseif nodeDistribution == NodeDistribution.thickInternal then
      r[i] = rint + 1/(rext - rint)*(r_lin[i] - rint)^2
        "Quadratically distributed node radii - thickest at rint";
    elseif nodeDistribution == NodeDistribution.thickExternal then
      r[i] = rext - 1/(rext - rint)*(rext - r_lin[i])^2
        "Quadratically distributed node radii - thickest at rext";
    elseif nodeDistribution == NodeDistribution.thickBoth then
      if r_lin[i] <= (rint + rext)/2 then
        r[i] = 2/(rext - rint)*(r_lin[i] - rint)^2 + rint
          "Quadratically distributed node radii - thickest at rint";
      else
        r[i] = -2/(rext - rint)*(r_lin[i] - rext)^2 + rext
          "Quadratically distributed node radii - thickest at rext";
      end if;
    else
      r[i] = 0;
      assert(true, "Unsupported NodeDistribution type");
    end if;
  end for;
  for i in 1:Nr - 1 loop
    r1_2[i] = (r[i + 1] + r[i])/2;
  end for;

  // Spatially discretized coefficients of Fourier's equation
  for i in 2:Nr - 1 loop
    A[i] = r1_2[i - 1]/(r[i]*(r[i] - r[i - 1])*(r1_2[i] - r1_2[i - 1]));
    C[i] = r1_2[i]/(r[i]*(r[i + 1] - r[i])*(r1_2[i] - r1_2[i - 1]));
    B[i] = -A[i] - C[i];
  end for;
  // Not used by Fourier equations
  A[1] = 0;
  B[1] = 0;
  C[1] = 0;
  A[Nr] = 0;
  B[Nr] = 0;
  C[Nr] = 0;

  // Metal temperature equations
  metal[1:Nr].T = T[1:Nr];

  // Thermal field
  for i in 2:Nr - 1 loop
    metal[i].density*metal[i].specificHeatCapacity/metal[i].thermalConductivity
      *der(T[i]) = A[i]*T[i - 1] + B[i]*T[i] + C[i]*T[i + 1]
      "Fourier's equation";
  end for;

  // Thermal boundary conditions
  internalBoundary.T[1] = T[1];
  externalBoundary.T[1] = T[Nr];
  internalBoundary.phi[1] = -metal[1].thermalConductivity*(T[2] - T[1])/(r[2]
     - r[1]);
  externalBoundary.phi[1] = metal[Nr].thermalConductivity*(T[Nr] - T[Nr - 1])/(
    r[Nr] - r[Nr - 1]);

  // Mean temperature
  Tm = 1/(rext^2 - rint^2)*sum((T[i]*r[i] + T[i + 1]*r[i + 1])*(r[i + 1] - r[i])
    for i in 1:Nr - 1);
  //  Tm = sum(T)/Nr;
initial equation
  // Initial conditions
  if initOpt == ORNL_AdvSMR.Choices.Init.Options.noInit then
    // do nothing
  elseif initOpt == ORNL_AdvSMR.Choices.Init.Options.steadyState then
    der(T[2:Nr - 1]) = zeros(Nr - 2);
  else
    assert(false, "Unsupported initialisation option");
  end if;
  annotation (
    Icon(graphics={Text(
          extent={{-94,52},{-42,24}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Forward,
          textString="Int"),Text(
          extent={{-90,-24},{-42,-50}},
          lineColor={0,0,0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Forward,
          textString="Ext"),Text(
          extent={{-98,-44},{102,-72}},
          lineColor={191,95,0},
          textString="%name")}),
    DymolaStoredErrors,
    Documentation(info="<html>
This is the 1D thermal model of a solid hollow cylinder by Fourier's equations. 
<p>The model is axis-symmetric, has one node in the longitudinal direction, and <tt>Nr</tt> nodes in the radial direction. The two connectors correspond to the internal and external surfaces; if one of the surface is thermally insulated, just leave the connector unconnected (no connection on a <tt>DHT</tt> connector means zero heat flux). The temperature-dependent properties of the material are described by the replaceable <tt>MaterialModel</tt> model.
<p><b>Modelling options</b></p>
The radial distribution of the nodes can be chosen by selecting the value of <tt>nodeDistribution</tt>:
<ul>
<li> <tt>Choices.CylinderFourier.NodeDistribution.uniform</tt> uniform distribution, nodes are equally spaced; 
<li> <tt>Choices.CylinderFourier.NodeDistribution.thickInternal</tt> quadratic distribution, nodes are thickest near the internal surface; 
<li> <tt>Choices.CylinderFourier.NodeDistribution.thickExternal</tt> quadratic distribution, nodes are thickest near the external surface; 
<li> <tt>Choices.CylinderFourier.NodeDistribution.thickBoth</tt> quadratic distribution, nodes are thickest near both surfaces.
</ul>
</html>", revisions="<html>
<ul>
<li><i>30 Dec 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Bugs fixed in boundary condition and node distribution.</li>
<li><i>1 May 2005</i>
    by <a href=\"mailto:luca.bascetta@polimi.it\">Luca Bascetta</a>:<br>
       First release.</li>
</ul>
</html>"));
end CylinderFourier;
