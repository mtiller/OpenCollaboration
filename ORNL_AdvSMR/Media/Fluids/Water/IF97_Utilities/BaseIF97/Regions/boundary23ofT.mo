within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function boundary23ofT
  "boundary function for region boundary between regions 2 and 3 (input temperature)"

  extends Modelica.Icons.Function;
  input SI.Temperature t "temperature (K)";
  output SI.Pressure p "pressure";
protected
  constant Real[5] n=data.n;
algorithm
  p := 1.0e6*(n[1] + t*(n[2] + t*n[3]));
end boundary23ofT;
