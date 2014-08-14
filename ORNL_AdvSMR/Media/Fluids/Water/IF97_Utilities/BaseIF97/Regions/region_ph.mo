within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function region_ph
  "return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific enthalpy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEnthalpy h "specific enthalpy";
  input Integer phase=0
    "phase: 2 for two-phase, 1 for one phase, 0 if not known";
  input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
  output Integer region "region (valid values: 1,2,3,4,5) in IF97";
  // If mode is different from 0, no checking for the region is done and
  // the mode is assumed to be the correct region. This can be used to
  // implement e.g., water-only steamtables when mode == 1
protected
  Boolean hsubcrit;
  SI.Temperature Ttest;
  constant Real[5] n=data.n;
  SI.SpecificEnthalpy hl "bubble enthalpy";
  SI.SpecificEnthalpy hv "dew enthalpy";
algorithm
  if (mode <> 0) then
    region := mode;
  else
    // check for regions 1, 2, 3 and 4
    hl := hl_p(p);
    hv := hv_p(p);
    if (phase == 2) then
      region := 4;
    else
      // phase == 1 or 0, now check if we are in the legal area
      if (p < triple.ptriple) or (p > data.PLIMIT1) or (h < hlowerofp1(p)) or (
          (p < 10.0e6) and (h > hupperofp5(p))) or ((p >= 10.0e6) and (h >
          hupperofp2(p))) then
        // outside of valid range
        region := -1;
      else
        //region 5 and -1 check complete
        hsubcrit := (h < data.HCRIT);
        // simple precheck: very simple if pressure < PLIMIT4A
        if (p < data.PLIMIT4A) then
          // we can never be in region 3, so test for others
          if hsubcrit then
            if (phase == 1) then
              region := 1;
            else
              if (h < Isentropic.hofpT1(p, Basic.tsat(p))) then
                region := 1;
              else
                region := 4;
              end if;
            end if;
            // external or internal phase check
          else
            if (h > hlowerofp5(p)) then
              // check for region 5
              if ((p < data.PLIMIT5) and (h < hupperofp5(p))) then
                region := 5;
              else
                region := -2;
                // pressure and specific enthalpy too high, but this should
              end if;
              // never happen
            else
              if (phase == 1) then
                region := 2;
              else
                if (h > Isentropic.hofpT2(p, Basic.tsat(p))) then
                  region := 2;
                else
                  region := 4;
                end if;
              end if;
              // external or internal phase check
            end if;
            // tests for region 2 or 5
          end if;
          // tests for sub or supercritical
        else
          // the pressure is over data.PLIMIT4A
          if hsubcrit then
            // region 1 or 3 or 4
            if h < hupperofp1(p) then
              region := 1;
            else
              if h < hl or p > data.PCRIT then
                region := 3;
              else
                region := 4;
              end if;
            end if;
            // enf of test for region 1, 3 or 4
          else
            // region 2, 3 or 4
            if (h > hlowerofp2(p)) then
              region := 2;
            else
              if h > hv or p > data.PCRIT then
                region := 3;
              else
                region := 4;
              end if;
            end if;
            // test for 2 and 3
          end if;
          // tests above PLIMIT4A
        end if;
        // above or below PLIMIT4A
      end if;
      // check for grand limits of p and h
    end if;
    // all tests with phase == 1
  end if;
  // mode was == 0
  // assert(region > 0,"IF97 function called outside the valid range!");
end region_ph;
