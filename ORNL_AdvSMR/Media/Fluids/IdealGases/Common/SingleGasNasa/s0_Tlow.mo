within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function s0_Tlow "Compute specific entropy, low T region"
  extends Modelica.Icons.Function;
  input DataRecord data "Ideal gas data";
  input SI.Temperature T "Temperature";
  output SI.SpecificEntropy s "Specific entropy at temperature T";
algorithm
  s := data.R*(data.blow[2] - 0.5*data.alow[1]/(T*T) - data.alow[2]/T + data.alow[
    3]*Math.log(T) + T*(data.alow[4] + T*(0.5*data.alow[5] + T*(1/3*data.alow[6]
     + 0.25*data.alow[7]*T))));
  annotation (InlineNoEvent=false,smoothOrder=1);
end s0_Tlow;
