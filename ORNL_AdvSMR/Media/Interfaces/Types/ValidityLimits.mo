within ORNL_AdvSMR.Media.Interfaces.Types;
record ValidityLimits "Limits of validity, also used in inverse iterations"
  Units.Temperature TMIN "Minimum Temperature";
  Units.Temperature TMAX "Maximum Temperature";
  Units.Density DMIN "Minimum Density";
  Units.Density DMAX "Maximum Density";
  Units.AbsolutePressure PMIN "Minimum Pressure";
  Units.AbsolutePressure PMAX "Maximim Pressure";
  Units.SpecificEnthalpy HMIN "Minimum specific enthalpy";
  Units.SpecificEnthalpy HMAX "Maximum specific enthalpy";
  Units.SpecificEntropy SMIN "Minimum specific entropy";
  Units.SpecificEntropy SMAX "Maximum specific entropy";
end ValidityLimits;
