within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function rhov_p_R4b
  "explicit approximation of vapour density on the boundary between regions 4 and 2"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  output SI.Density dv "vapour density";
protected
  Real x "auxiliary variable";
algorithm
  if (p < data.PCRIT) then
    x := Modelica.Math.acos(p/data.PCRIT);
    dv := (1 + x*(-1.8463850803362596 + x*(-1.1447872718878493
       + x*(59.18702203076563 + x*(-403.5391431811611 + x*(
      1437.2007245332388 + x*(-3015.853540307519 + x*(
      3740.5790348670057 + x*(-2537.375817253895 + (
      725.8761975803782 - 0.0011151111658332337*x)*x)))))))))*
      data.DCRIT;
  else
    dv := data.DCRIT;
  end if;
end rhov_p_R4b;
