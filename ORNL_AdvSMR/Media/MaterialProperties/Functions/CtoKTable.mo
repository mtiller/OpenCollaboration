within ORNL_AdvSMR.Media.MaterialProperties.Functions;
function CtoKTable
  extends Modelica.SIunits.Conversions.ConversionIcon;

  input Real[:, :] table_degC;
  output Real table_degK[size(table_degC, 1), size(table_degC, 2)];
algorithm
  table_degK := table_degC;

  for i in 1:size(table_degC, 1) loop
    table_degK[i, 1] := Modelica.SIunits.Conversions.from_degC(table_degC[i, 1]);
  end for;
end CtoKTable;
