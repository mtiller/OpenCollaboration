within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function cp_Tlow_der
  "Compute specific heat capacity at constant pressure, low T region"
  extends Modelica.Icons.Function;
  input DataRecord data "Ideal gas data";
  input SI.Temperature T "Temperature";
  input Real dT "Temperature derivative";
  output Real cp_der "Derivative of specific heat capacity";
algorithm
  cp_der := dT*data.R/(T*T*T)*(-2*data.alow[1] + T*(-data.alow[2] + T*T*(data.alow[
    4] + T*(2.*data.alow[5] + T*(3.*data.alow[6] + 4.*data.alow[7]*T)))));
end cp_Tlow_der;
