within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Regions;
function region_ps
  "return the current region (valid values: 1,2,3,4,5) in IF97 for given pressure and specific entropy"
  extends Modelica.Icons.Function;
  input SI.Pressure p "pressure";
  input SI.SpecificEntropy s "specific entropy";
  input Integer phase=0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
  input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
  output Integer region "region (valid values: 1,2,3,4,5) in IF97";
  //  If mode is different from 0, no checking for the region is done and
  //    the mode is assumed to be the correct region. This can be used to
  //    implement e.g., water-only steamtables when mode == 1
protected
  Boolean ssubcrit;
  SI.Temperature Ttest;
  constant Real[5] n=data.n;
  SI.SpecificEntropy sl "bubble entropy";
  SI.SpecificEntropy sv "dew entropy";
algorithm
  if (mode <> 0) then
    region := mode;
  else
    // check for regions 1, 2, 3, and 4
    sl := sl_p(p);
    sv := sv_p(p);
    // check all cases two-phase
    if (phase == 2) or (phase == 0 and s > sl and s < sv and p
         < data.PCRIT) then
      region := 4;
    else
      // phase == 1
      region := 0;
      if (p < triple.ptriple) then
        region := -2;
      end if;
      if (p > data.PLIMIT1) then
        region := -3;
      end if;
      if ((p < 10.0e6) and (s > supperofp5(p))) then
        region := -5;
      end if;
      if ((p >= 10.0e6) and (s > supperofp2(p))) then
        region := -6;
      end if;
      if region < 0 then
        assert(false,
          "region computation from p and s failed: function called outside the legal region");
      else
        ssubcrit := (s < data.SCRIT);
        // simple precheck: very simple if pressure < PLIMIT4A
        if (p < data.PLIMIT4A) then
          // we can never be in region 3, so test for 1 and 2
          if ssubcrit then
            region := 1;
          else
            if (s > slowerofp5(p)) then
              // check for region 5
              if ((p < data.PLIMIT5) and (s < supperofp5(p))) then
                region := 5;
              else
                region := -1;
                // pressure and specific entropy too high, should never happen!
              end if;
            else
              region := 2;
            end if;
            // tests for region 2 or 5
          end if;
          // tests for sub or supercritical
        else
          // the pressure is over data.PLIMIT4A
          if ssubcrit then
            // region 1 or 3
            if s < supperofp1(p) then
              region := 1;
            else
              if s < sl or p > data.PCRIT then
                region := 3;
              else
                region := 4;
              end if;
            end if;
            // test for region 1, 3 or 4
          else
            // region 2, 3 or 4
            if (s > slowerofp2(p)) then
              region := 2;
            else
              if s > sv or p > data.PCRIT then
                region := 3;
              else
                region := 4;
              end if;
            end if;
            // test for 2,3 and 4
          end if;
          // tests above PLIMIT4A
        end if;
        // above or below PLIMIT4A
      end if;
      // grand test for limits of p and s
    end if;
    // all tests with phase == 1
  end if;
  // mode was == 0
end region_ps;
