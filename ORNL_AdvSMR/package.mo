within ;
package ORNL_AdvSMR "This is the top-level library that contains packages for various advanced SMR concepts."
extends Modelica.Icons.Library;

import Modelica.SIunits.*;


annotation (uses(
    UserInteraction(version="0.62"),
    Modelica(version="3.2.1"),
    ThermoPower3(version="3.1"),
    FuelThermalDynamics(version="1")), version="1");
end ORNL_AdvSMR;
