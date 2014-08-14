within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
function getpstar "get normalization pressure for region 1, 2 or 5"
  extends Modelica.Icons.Function;
  input Integer region "IF 97 region";
  output SI.Pressure pstar "normalization pressure";
algorithm
  if region == 1 then
    pstar := data.PSTAR1;
  elseif region == 2 then
    pstar := data.PSTAR2;
  else
    pstar := data.PSTAR5;
  end if;
end getpstar;
