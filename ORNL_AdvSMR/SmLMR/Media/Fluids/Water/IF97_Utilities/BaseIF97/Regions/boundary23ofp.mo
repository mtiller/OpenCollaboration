within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function boundary23ofp
  "boundary function for region boundary between regions 2 and 3 (input pressure)"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.Temperature t "temperature (K)";
protected
  constant Real[5] n=data.n;
  Real pi "dimensionless pressure";
algorithm
  pi := p/1.0e6;
  assert(p > triple.ptriple,
    "IF97 medium function boundary23ofp called with too low pressure\n"
     + "p = " + String(p) + " Pa <= " + String(triple.ptriple)
     + " Pa (triple point pressure)");
  t := n[4] + ((pi - n[5])/n[3])^0.5;
end boundary23ofp;
