within ORNL_AdvSMR.PowerSystems.HeatExchangers.HelicalCoilSteamGenerator;
function SGPrimaryAndMetal
  "Calculates the primary enthalpy derivatives based on conservation of energy"

  extends Modelica.Icons.Function;

  import SI = Modelica.SIunits;
  import NonSI = Modelica.SIunits.Conversions.NonSIunits;

protected
  SI.Length Dptube=2.6;
  Real v;
  Real rpe;
  Real Wp[5];
  Real rpri[4];
  SI.AbsolutePressure p;
  SI.SpecificEnthalpy h;
  Real dz;
  Real dzs;
  Real dzn;
  SI.SpecificEnthalpy hs;
  SI.SpecificEnthalpy hn;
  SI.Temperature Tms;
  SI.Temperature Tmn;
  Real CDWs;
  Real CDWn;
  Real CDTs;
  Real CDTn;

public
  input Real dzdt[5](unit="m/s") "Axial time derivative";
  input Real Wpri;
  input SI.AbsolutePressure Ppri;
  input SI.SpecificEnthalpy hpe;
  input Real hplR;
  input Real hpri[4];
  input SI.Temperature Tm[5];
  input SI.Length z[5];
  input Real Qpri[5];
  input Real Qsec[5];
  input Real Dpwater;
  input SI.Area Apri;
  input SI.Area Atube;
  input Real rtube;
  input Real cptube;
  output Real dhdt[4];
  output Real dTmdt[4];

algorithm
  p := Ppri;
  h := hpe;
  v := 9.6977e-004 - 7.9787e-007*p + 2.7568e-007*h - 6.4795e-010*p*h +
    1.9181e-008*p*p - 2.7811e-010*h*h + 2.5255e-013*h*h*h - 9.9213e-010*p*p*p
     + 8.0977e-011*p*p*h - 2.2310e-012*p*h*h;

  rpe := 1 ./ v;

  /*
  Account for the flow through the moving boundary.
  Positive flow on primary is down; 
  positive boundary derivative is up 
  hence the + sigh on the moving boundary term.
  Wp is flow through boundary as seen by an observer
  traveling with the boundary.
  */
  Wp := Wpri*ones(5) .+ Apri*rpe*dzdt;

  /*
  Set up the North (top) and South (bottom) parameters
  following Patankar terminology for cell boundaries.
  */
  rpri := zeros(4);
  dhdt := zeros(4);
  dTmdt := zeros(4);

  for ii in 1:4 loop
    h := hpri[ii];
    v := 9.6977e-004 - 7.9787e-007*p + 2.7568e-007*h - 6.4795e-010*p*h +
      1.9181e-008*p*p - 2.7811e-010*h*h + 2.5255e-013*h*h*h - 9.9213e-010*p*p*p
       + 8.0977e-011*p*p*h - 2.2310e-012*p*h*h;

    rpri[ii] := 1 ./ v;

    if ii > 1 then
      dzs := (z[ii + 1] - z[ii - 1])/2;
      hs := hpri[ii - 1];
      Tms := Tm[ii - 1];
    else
      dzs := z[2]/2;
      hs := hplR;
      Tms := Tm[1];
    end if;

    if ii == 4 then
      dzn := (z[5] - z[4])/2;
      hn := hpe;
      Tmn := Tm[4];
    else
      dzn := (z[ii + 2] - z[ii])/2;
      hn := hpri[ii + 1];
      Tmn := Tm[ii + 1];
    end if;

    /*
    CDw and CDe are the "convection + diffusion" coefficients
    utilizing the hybrid scheme of Patankar Numerical Heat Transfer
    and Fluid Flow p. 82.
    The effect is basically upwind differencing except at very low flow
    when axial conduction smoothes the transition across flow reversal.
    */
    dz := z[ii + 1] - z[ii];
    CDWs := max([-Wp[ii], -Wp[ii]/2 + Dpwater/dzs, 0]);
    CDWn := max([Wp[ii + 1], Wp[ii + 1]/2 + Dpwater/dzn, 0]);
    CDTs := max([-dzdt[ii], -dzdt[ii]/2 + Dptube/dzs, 0]);
    CDTn := max([dzdt[ii + 1], dzdt[ii + 1]/2 + Dptube/dzn, 0]);
    dhdt[ii] := (CDWn*(hn - hpri[ii]) + CDWs*(hs - hpri[ii]) - Qpri[ii])/(Apri*
      rpri[ii]*dz);
    dTmdt[ii] := ((Qpri[ii] - Qsec[ii])/(Atube*rtube*cptube) + CDTn*(Tmn - Tm[
      ii]) + CDTs*(Tms - Tm[ii]))/dz;

  end for;

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5}), graphics={Bitmap(extent={{-100,100},{100,-100}},
          fileName="modelica://aSMR/Icons/HelicalCoilSteamGenerator.png")}),
      Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={0.5,0.5})));
end SGPrimaryAndMetal;
