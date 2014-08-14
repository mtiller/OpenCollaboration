within ORNL_AdvSMR.Thermal;
connector HThtc
  "Thermal port for lumped parameter heat transfer with outgoing heat transfer coefficient"
  extends HT;
  output Modelica.SIunits.ThermalConductance G "Thermal conductance";
end HThtc;
