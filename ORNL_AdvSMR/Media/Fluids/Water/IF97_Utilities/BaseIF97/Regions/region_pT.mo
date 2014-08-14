within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function region_pT
  "return the current region (valid values: 1,2,3,5) in IF97, given pressure and temperature"

  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.Temperature T "temperature (K)";
  input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
  output Integer region
    "region (valid values: 1,2,3,5) in IF97, region 4 is impossible!";
algorithm
  if (mode <> 0) then
    region := mode;
  else
    if p < data.PLIMIT4A then
      //test for regions 1,2,5
      if T > data.TLIMIT2 then
        region := 5;
      elseif T > Basic.tsat(p) then
        region := 2;
      else
        region := 1;
      end if;
    else
      //test for regions 1,2,3
      if T < data.TLIMIT1 then
        region := 1;
      elseif T < boundary23ofp(p) then
        region := 3;
      else
        region := 2;
      end if;
    end if;
  end if;
  // mode was == 0
end region_pT;
