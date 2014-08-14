within ORNL_AdvSMR.Media.Interfaces.Types;
record PrimaryLimits
  "Primary limits of validity, also used in inverse iterations"
  Units.Temperature TMIN "Minimum Temperature";
  Units.Temperature TMAX "Maximum Temperature";
  Units.Density DMIN "Minimum Density";
  Units.Density DMAX "Maximum Density";
  Units.AbsolutePressure PMIN "Minimum Pressure";
  Units.AbsolutePressure PMAX "Maximim Pressure";
end PrimaryLimits;
