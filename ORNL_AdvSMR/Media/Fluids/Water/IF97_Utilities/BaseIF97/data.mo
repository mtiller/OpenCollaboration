within ORNL_AdvSMR.Media.Fluids.Water.IF97_Utilities.BaseIF97;
record data "constant IF97 data and region limits"
  extends Modelica.Icons.Record;
  constant SI.SpecificHeatCapacity RH2O=461.526
    "specific gas constant of water vapour";
  constant SI.MolarMass MH2O=0.01801528 "molar weight of water";
  constant SI.Temperature TSTAR1=1386.0
    "normalization temperature for region 1 IF97";
  constant SI.Pressure PSTAR1=16.53e6
    "normalization pressure for region 1 IF97";
  constant SI.Temperature TSTAR2=540.0
    "normalization temperature for region 2 IF97";
  constant SI.Pressure PSTAR2=1.0e6 "normalization pressure for region 2 IF97";
  constant SI.Temperature TSTAR5=1000.0
    "normalization temperature for region 5 IF97";
  constant SI.Pressure PSTAR5=1.0e6 "normalization pressure for region 5 IF97";
  constant SI.SpecificEnthalpy HSTAR1=2.5e6
    "normalization specific enthalpy for region 1 IF97";
  constant Real IPSTAR=1.0e-6
    "normalization pressure for inverse function in region 2 IF97";
  constant Real IHSTAR=5.0e-7
    "normalization specific enthalpy for inverse function in region 2 IF97";
  constant SI.Temperature TLIMIT1=623.15
    "temperature limit between regions 1 and 3";
  constant SI.Temperature TLIMIT2=1073.15
    "temperature limit between regions 2 and 5";
  constant SI.Temperature TLIMIT5=2273.15 "upper temperature limit of 5";
  constant SI.Pressure PLIMIT1=100.0e6
    "upper pressure limit for regions 1, 2 and 3";
  constant SI.Pressure PLIMIT4A=16.5292e6
    "pressure limit between regions 1 and 2, important for for two-phase (region 4)";
  constant SI.Pressure PLIMIT5=10.0e6
    "upper limit of valid pressure in region 5";
  constant SI.Pressure PCRIT=22064000.0 "the critical pressure";
  constant SI.Temperature TCRIT=647.096 "the critical temperature";
  constant SI.Density DCRIT=322.0 "the critical density";
  constant SI.SpecificEntropy SCRIT=4412.02148223476
    "the calculated specific entropy at the critical point";
  constant SI.SpecificEnthalpy HCRIT=2087546.84511715
    "the calculated specific enthalpy at the critical point";
  constant Real[5] n=array(
      0.34805185628969e3,
      -0.11671859879975e1,
      0.10192970039326e-2,
      0.57254459862746e3,
      0.13918839778870e2)
    "polynomial coefficients for boundary between regions 2 and 3";
  annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
                           <p>Constants needed in the international steam properties IF97.
                           SCRIT and HCRIT are calculated from Helmholtz function for region 3.</p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by Hubertus Tummescheit
       </li>
</ul>
 <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</HTML>
"));
end data;
