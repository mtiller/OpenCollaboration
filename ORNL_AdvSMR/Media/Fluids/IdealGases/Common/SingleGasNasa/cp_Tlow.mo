within ORNL_AdvSMR.Media.Fluids.IdealGases.Common.SingleGasNasa;
function cp_Tlow
  "Compute specific heat capacity at constant pressure, low T region"
  extends Modelica.Icons.Function;
  input DataRecord data "Ideal gas data";
  input SI.Temperature T "Temperature";
  output SI.SpecificHeatCapacity cp "Specific heat capacity at temperature T";
algorithm
  cp := data.R*(1/(T*T)*(data.alow[1] + T*(data.alow[2] + T*(1.*data.alow[3] +
    T*(data.alow[4] + T*(data.alow[5] + T*(data.alow[6] + data.alow[7]*T)))))));
  annotation (Inline=false, derivative(zeroDerivative=data) = cp_Tlow_der);
end cp_Tlow;
