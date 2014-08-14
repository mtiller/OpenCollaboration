within ORNL_AdvSMR.Media.Fluids.IncompressibleLiquids.TableBased;
function invertTemp "function to invert temperatures"
  input Real[:] table "table temperature data";
  input Boolean Tink "flag for Celsius or Kelvin";
  output Real invTable[size(table, 1)] "inverted temperatures";
algorithm
  for i in 1:size(table, 1) loop
    invTable[i] := if TinK then 1/table[i] else 1/Cv.from_degC(table[i]);
  end for;
end invertTemp;
