within ORNL_AdvSMR.PRISM.Media.Fluids.Air;
package SimpleAir "Air: Simple dry air model (0..100 degC)"


extends Interfaces.PartialSimpleIdealGasMedium(
  mediumName="SimpleAir",
  cp_const=1005.45,
  MM_const=0.0289651159,
  R_gas=Constants.R/0.0289651159,
  eta_const=1.82e-5,
  lambda_const=0.026,
  T_min=Cv.from_degC(0),
  T_max=Cv.from_degC(100));

import SI = Modelica.SIunits;
import Cv = Modelica.SIunits.Conversions;
import Modelica.Constants;

constant FluidConstants[nS] fluidConstants=FluidConstants(
    iupacName={"simple air"},
    casRegistryNumber={"not a real substance"},
    chemicalFormula={"N2, O2"},
    structureFormula={"N2, O2"},
    molarMass=Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM)
  "constant data for the fluid";


annotation (Documentation(info="<html>
                              <h4>Simple Ideal gas air model for low temperatures</h4>
                              <p>This model demonstrats how to use the PartialSimpleIdealGas base class to build a
                              simple ideal gas model with a limited temperature validity range.</p>
                              </html>"));
end SimpleAir;
