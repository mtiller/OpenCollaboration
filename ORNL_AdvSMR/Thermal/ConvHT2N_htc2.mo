within ORNL_AdvSMR.Thermal;
model ConvHT2N_htc2
  "1D Convective heat transfer between two DHT connectors with a different number of nodes"
  import aSMR = ORNL_AdvSMR;
  extends ORNL_AdvSMR.Icons.HeatFlow;
  parameter Integer N1(min=1) = 2 "Number of nodes on side 1";
  parameter Integer N2(min=1) = 2 "Number of nodes on side 2";
  ORNL_AdvSMR.Thermal.DHThtc_in side1(N=N1) annotation (Placement(
        transformation(extent={{-40,20},{40,40}}, rotation=0)));
  ORNL_AdvSMR.Thermal.DHThtc side2(N=N2) annotation (Placement(transformation(
          extent={{-40,-42},{40,-20}}, rotation=0)));
protected
  parameter Real H12[:, :]=(if N1 >= N2 then ones(N1, N2) else
      Modelica.Math.Matrices.inv(H1)*H2)
    "Heat flux weight matrix to use if N2>N1" annotation (Evaluate=true);
  parameter Real H21[:, :]=(if N1 >= N2 then Modelica.Math.Matrices.inv(H2)*H1
       else ones(N2, N1)) "Heat flux weight matrix to use if N1>=N2"
    annotation (Evaluate=true);
  parameter Real G1[N2, N1]=compG1(N1, N2) "Temperature weight matrix - side 1";
  parameter Real G2[N1, N2]=compG2(N1, N2) "Temperature weight matrix - side 2";
  parameter Real H1[min(N1, N2), N1]=compH1(N1, N2)
    "Heat flux weight matrix - side 1" annotation (Evaluate=true);
  parameter Real H2[min(N1, N2), N2]=compH2(N1, N2)
    "Heat flux weight matrix - side 2" annotation (Evaluate=true);

  function compHm "Computes matrix H - side with more nodes"
    input Integer Nm "Number of nodes on the side with more nodes";
    input Integer Nf "Number of nodes on the side with fewer nodes";
    output Real H[Nf, Nm] "Temperature weight matrix";
  algorithm
    H := zeros(Nf, Nm);
    // Flux on the first semi-cell, few nodes side
    H[1, :] := fluxWeights(
        Nm,
        0,
        0.5/(Nf - 1));
    // Flux on the central cells, few nodes side
    for i in 2:Nf - 1 loop
      H[i, :] := fluxWeights(
          Nm,
          (i - 1.5)/(Nf - 1),
          (i - 0.5)/(Nf - 1));
    end for;
    // Flux on the last semi-cell, few nodes side
    H[Nf, :] := fluxWeights(
        Nm,
        1 - 0.5/(Nf - 1),
        1);
  end compHm;

  function fluxWeights "Returns the vector of the weights of the nodal fluxes 
     (more nodes side) corresponding to the given boundaries"
    input Integer Nm "Number of nodes on the side with more nodes";
    input Real lb "Left boundary, normalised";
    input Real rb "Right boundary, normalised";
    output Real v[Nm] "Flux weight vector";
  protected
    Integer lbi "Index of the leftmost involved node";
    Integer rbi "Index of the rightmost involved node";
    Real h "Width of the inner cells";
    Real hl "Width of the leftmost cell";
    Real hr "Width of the rightmost cell";
  algorithm
    v := zeros(Nm);
    // Index of the rightmost and leftmost involved nodes
    lbi := 1 + integer(floor(lb*(Nm - 1) - 1e-6));
    rbi := 1 + integer(ceil(rb*(Nm - 1) + 1e-6));
    // Width of the inner, leftmost and rightmost cells
    h := 1/(Nm - 1);
    hl := lbi*h - lb;
    hr := rb - (rbi - 2)*h;
    // Coefficients of the contribution of the leftmost partial cell flow
    if abs(hl) > 1e-6 then
      v[lbi] := (hl/h)/2*hl;
      v[lbi + 1] := ((h - hl)/h + 1)/2*hl;
    end if;
    // Coefficients of the contribution of the rightmost partial cell flow
    if abs(hr) > 1e-6 then
      v[rbi - 1] := (1 + (h - hr)/h)/2*hr;
      v[rbi] := (hr/h)/2*hr;
    end if;
    // Coefficients of the additional contributions of the internal cells
    for i in lbi + 1:rbi - 2 loop
      v[i] := v[i] + h/2;
      v[i + 1] := v[i + 1] + h/2;
    end for;
    // Coefficients are scaled to get the average flux from the flow
    v := v/(rb - lb);
  end fluxWeights;

  function compHf "Computes matrix H - side with fewer nodes"
    input Integer Nf "Number of nodes on the side with fewer nodes";
    output Real H[Nf, Nf] "Heat flux weight matrix";
  algorithm
    H := zeros(Nf, Nf);
    // Flux on the first semi-cell is average(phi[1],average(phi[1],phi[2]))
    H[1, 1:2] := {3/4,1/4};
    // Flux on the central cells is the average between the flux on the left
    // semi-cell average(average(phi[i-1],phi[i]),phi[i]) and the flux on the right
    // semi-cell average(phi[i],average(phi[i],phi[i+1]))
    for i in 2:Nf - 1 loop
      H[i, i - 1:i + 1] := {1/8,3/4,1/8};
    end for;
    // Flux on the last semi-cell is average(average(phi[Nf-1],phi[Nf]), phi[Nf])
    H[Nf, Nf - 1:Nf] := {1/4,3/4};
  end compHf;

  function compG "Computes matrix G"
    input Integer Nm "Number of nodes on the side with more nodes";
    input Integer Nf "Number of nodes on the side with fewer nodes";
    output Real G[Nm, Nf] "Temperature weight matrix";
  protected
    Integer firstNode
      "Number of the left corresponding node on the side with fewer nodes";
    Integer lastNode
      "Number of the right corresponding node on the side with fewer nodes";
    Real w "Temperature weight of the left corresponding node ";
  algorithm
    G := zeros(Nm, Nf);
    G[1, 1] := 1 "Temperature of first node";
    G[Nm, Nf] := 1 "Temperature of last node";
    // Temperature of internal nodes by interpolation
    for i in 2:Nm - 1 loop
      firstNode := 1 + div((Nf - 1)*(i - 1), Nm - 1);
      lastNode := 1 + firstNode;
      w := 1 - mod((Nf - 1)*(i - 1), Nm - 1)/(Nm - 1);
      G[i, firstNode] := w;
      G[i, lastNode] := 1 - w;
    end for;
  end compG;

  function compG1 "Computes matrix G1"
    input Integer N1;
    input Integer N2;
    output Real G1[N2, N1];
  algorithm
    G1 := if N1 == N2 then identity(N1) else if N1 > N2 then zeros(N2, N1)
       else compG(max(N1, N2), min(N1, N2));
  end compG1;

  function compG2 "Computes matrix G2"
    input Integer N1;
    input Integer N2;
    output Real G2[N1, N2];
  algorithm
    G2 := if N1 == N2 then identity(N1) else if N1 > N2 then compG(max(N1, N2),
      min(N1, N2)) else zeros(N1, N2);
  end compG2;

  function compH1 "Computes matrix H1"
    input Integer N1;
    input Integer N2;
    output Real H1[min(N1, N2), N1];
  algorithm
    H1 := if N1 == N2 then identity(N1) else if N1 > N2 then compHm(max(N1, N2),
      min(N1, N2)) else compHf(min(N1, N2));
  end compH1;

  function compH2 "Computes matrix H2"
    input Integer N1;
    input Integer N2;
    output Real H2[min(N1, N2), N2];
  algorithm
    H2 := if N1 == N2 then identity(N2) else if N1 > N2 then compHf(min(N1, N2))
       else compHm(max(N1, N2), min(N1, N2));
  end compH2;

equation
  //H1*side1.phi+H2*side2.phi = zeros(min(N1,N2)) "Energy balance";
  side2.gamma = side1.gamma[1]*ones(N2);
  if N1 >= N2 then
    side1.phi = side1.gamma[1]*(side1.T - G2*side2.T)
      "Convective heat transfer";
    side2.phi = -H21*side1.phi;
  else
    side2.phi = side1.gamma[1]*(side2.T - G1*side1.T)
      "Convective heat transfer";
    side1.phi = -H12*side2.phi;
  end if;
  annotation (Icon(graphics={Text(
          extent={{-100,-44},{100,-68}},
          lineColor={191,95,0},
          textString="%name"),Text(
          extent={{-118,46},{-30,14}},
          lineColor={191,95,0},
          textString="fluid"),Text(
          extent={{34,48},{122,16}},
          lineColor={191,95,0},
          textString="side")}), Documentation(info="<HTML>
<p>Model of a simple convective heat transfer mechanism between two 1D objects having (possibly) different nodes, with a constant heat transfer coefficient.
<p>The heat flux through each node of side with a larger number of nodes is computed as a function of the difference between the node temperatures and the corresponding temperatures on the other side, obtained by linear interpolation.
<p>The corresponding heat flux on the side with fewer nodes is computed so that the averaged heat flux around those nodes is equal to the averaged heat flux on the corresponding intervals on the other side.
</HTML>", revisions="<html>
<ul>
<li><i>12 May 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"));
end ConvHT2N_htc2;
