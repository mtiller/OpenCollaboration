within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.IceBoundaries;
function pmIceIII_T
  "Melting pressure of ice III (temperature range from 251.165 to 256.164 K)"
  extends Modelica.Icons.Function;
  input SI.Temp_K T "Temperature";
  output SI.Pressure pm
    "Melting pressure of iceIII(for T from 251.165 to 256.164 K)";
protected
  constant SI.Temp_K Tn=251.165 "normalization temperature";
  constant SI.Pressure pn=209.9e6 "normalization pressure";
  Real sigma=T/Tn "normalized temperature";
algorithm
  pm := (1 - 0.295252*(1 - sigma^60))*pn;
  annotation (Documentation(info="<html>
  <p>
  Equation 2 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
end pmIceIII_T;
