within ORNL_AdvSMR.Thermal;
connector HThtc_in
  "Thermal port for lumped parameter heat transfer with incoming heat transfer coefficient"
  extends HT;
  input Modelica.SIunits.ThermalConductance G "Thermal conductance";
end HThtc_in;
