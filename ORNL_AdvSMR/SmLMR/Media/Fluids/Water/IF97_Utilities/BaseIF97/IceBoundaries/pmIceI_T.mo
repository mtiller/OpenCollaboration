within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.IceBoundaries;
function pmIceI_T
  "Melting pressure of ice I (temperature range from 273.16 to 251.165 K)"
  extends Modelica.Icons.Function;
  input SI.Temp_K T "Temperature";
  output SI.Pressure pm
    "Melting pressure of iceI(for T from 273.16 to 251.165 K)";
protected
  constant SI.Temp_K Tn=273.16 "normalization temperature";
  constant SI.Pressure pn=611.657 "normalization pressure";
  Real sigma=T/Tn "normalized temperature";
algorithm
  pm := (1 - 0.626000e6*(1 - sigma^(-3)) + 0.197135e6*(1 -
    sigma^(21.2)))*pn;
  annotation (Documentation(info="<html>
  <p>
  Equation 1 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
end pmIceI_T;
