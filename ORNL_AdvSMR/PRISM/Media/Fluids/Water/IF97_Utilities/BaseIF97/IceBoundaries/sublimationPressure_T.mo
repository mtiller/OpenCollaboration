within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.IceBoundaries;
function sublimationPressure_T
  "Sublimation pressure, valid from 190 to 273.16 K"
  extends Modelica.Icons.Function;
  input SI.Temp_K T "Temperature";
  output SI.Pressure psubl "sublimation pressure (for T from 190 to 273.16)";
protected
  constant SI.Temp_K Tn=273.16 "normalization temperature";
  constant SI.Pressure pn=611.657 "normalization pressure";
  constant Real[2] a={-13.9281690,34.7078238} "constant values";
  Real sigma=T/Tn "normalized temperature";
algorithm
  psubl := Modelica.Math.exp(a[1]*(1 - sigma^(-1.5)) + a[2]*(1
     - sigma^(-1.25)))*pn;
  annotation (Documentation(info="<html>
  <p>
  Equation 6 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
end sublimationPressure_T;
