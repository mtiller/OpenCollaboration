within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.IceBoundaries;
function pmIceV_T
  "Melting pressure of ice V (temperature range from 256.164 to 273.31 K)"
  extends Modelica.Icons.Function;
  input SI.Temp_K T "Temperature";
  output SI.Pressure pm
    "Melting pressure of iceV(for T from 256.164 to 273.31 K)";
protected
  constant SI.Temp_K Tn=256.164 "normalization temperature";
  constant SI.Pressure pn=350.1e6 "normalization pressure";
  Real sigma=T/Tn "normalized temperature";

algorithm
  pm := (1 - 1.18721*(1 - sigma^8))*pn;
  annotation (Documentation(info="<html>
  <p>
  Equation 3 from:<br>
  The International Association for the Properties of Water and Steam<br>
  Milan, Italy<br>
  September 1993<br>
  Release on the Pressure along the Melting and the Sublimation Curves of
  Ordinary Water Substance<br>
</p>
  </html>
  "));
end pmIceV_T;
