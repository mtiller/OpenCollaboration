within ORNL_AdvSMR.PRISM.Media.Fluids.Water.IF97_Utilities.BaseIF97;
function getTstar "get normalization temperature for region 1, 2 or 5"
  extends Modelica.Icons.Function;
  input Integer region "IF 97 region";
  output SI.Temperature Tstar "normalization temperature";
algorithm
  if region == 1 then
    Tstar := data.TSTAR1;
  elseif region == 2 then
    Tstar := data.TSTAR2;
  else
    Tstar := data.TSTAR5;
  end if;
end getTstar;
