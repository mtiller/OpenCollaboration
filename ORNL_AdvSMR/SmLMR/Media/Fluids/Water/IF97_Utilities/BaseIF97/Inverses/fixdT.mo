within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Inverses;
function fixdT "region limits for inverse iteration in region 3"

  extends Modelica.Icons.Function;
  input SI.Density din "density";
  input SI.Temperature Tin "temperature";
  output SI.Density dout "density";
  output SI.Temperature Tout "temperature";
protected
  SI.Temperature Tmin "approximation of minimum temperature";
  SI.Temperature Tmax "approximation of maximum temperature";
algorithm
  if (din > 765.0) then
    dout := 765.0;
  elseif (din < 110.0) then
    dout := 110.0;
  else
    dout := din;
  end if;
  if (dout < 390.0) then
    Tmax := 554.3557377 + dout*0.809344262;
  else
    Tmax := 1116.85 - dout*0.632948717;
  end if;
  if (dout < data.DCRIT) then
    Tmin := data.TCRIT*(1.0 - (dout - data.DCRIT)*(dout - data.DCRIT)
      /1.0e6);
  else
    Tmin := data.TCRIT*(1.0 - (dout - data.DCRIT)*(dout - data.DCRIT)
      /1.44e6);
  end if;
  if (Tin < Tmin) then
    Tout := Tmin;
  elseif (Tin > Tmax) then
    Tout := Tmax;
  else
    Tout := Tin;
  end if;
end fixdT;
