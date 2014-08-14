within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function region_dT
  "return the current region (valid values: 1,2,3,4,5) in IF97, given density and temperature"
  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature (K)";
  input Integer phase=0
    "phase: 2 for two-phase, 1 for one phase, 0 if not known";
  input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
  output Integer region "(valid values: 1,2,3,4,5) in IF97";
protected
  Boolean Tovercrit "flag if overcritical temperature";
  SI.Pressure p23 "pressure needed to know if region 2 or 3";
algorithm
  Tovercrit := T > data.TCRIT;
  if (mode <> 0) then
    region := mode;
  else
    p23 := boundary23ofT(T);
    if T > data.TLIMIT2 then
      if d < 20.5655874106483 then
        // check for the density in the upper corner of validity!
        region := 5;
      else
        assert(false,
          "out of valid region for IF97, pressure above region 5!");
      end if;
    elseif Tovercrit then
      //check for regions 1, 2 or 3
      if d > d2n(p23, T) and T > data.TLIMIT1 then
        region := 3;
      elseif T < data.TLIMIT1 then
        region := 1;
      else
        // d  < d2n(p23, T) and T > data.TLIMIT1
        region := 2;
      end if;
      // below critical, check for regions 1, 2, 3 or 4
    elseif (d > rhol_T(T)) then
      // either 1 or 3
      if T < data.TLIMIT1 then
        region := 1;
      else
        region := 3;
      end if;
    elseif (d < rhov_T(T)) then
      // not liquid, not 2-phase, and not region 5, so either 2 or 3 or illegal
      if (d > d2n(p23, T) and T > data.TLIMIT1) then
        region := 3;
      else
        region := 2;
      end if;
    else
      region := 4;
    end if;
  end if;
end region_dT;
