within ORNL_AdvSMR.SmLMR.Media.Common;
record BridgmansTables
  "Calculates all entries in Bridgmans tables if first seven variables given"
  extends Modelica.Icons.Record;
  // the first 7 need to calculated in a function!
  SI.SpecificVolume v "specific volume";
  SI.Pressure p "pressure";
  SI.Temperature T "temperature";
  SI.SpecificEntropy s "specific entropy";
  SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
  IsobaricVolumeExpansionCoefficient alpha
    "isobaric volume expansion coefficient";
  // beta in Bejan
  IsothermalCompressibility gamma "isothermal compressibility";
  // kappa in Bejan
  // Derivatives at constant pressure
  Real dTp=1 "coefficient in Bridgmans table, see info for usage";
  Real dpT=-dTp "coefficient in Bridgmans table, see info for usage";
  Real dvp=alpha*v "coefficient in Bridgmans table, see info for usage";
  Real dpv=-dvp "coefficient in Bridgmans table, see info for usage";
  Real dsp=cp/T "coefficient in Bridgmans table, see info for usage";
  Real dps=-dsp "coefficient in Bridgmans table, see info for usage";
  Real dup=cp - alpha*p*v "coefficient in Bridgmans table, see info for usage";
  Real dpu=-dup "coefficient in Bridgmans table, see info for usage";
  Real dhp=cp "coefficient in Bridgmans table, see info for usage";
  Real dph=-dhp "coefficient in Bridgmans table, see info for usage";
  Real dfp=-s - alpha*p*v "coefficient in Bridgmans table, see info for usage";
  Real dpf=-dfp "coefficient in Bridgmans table, see info for usage";
  Real dgp=-s "coefficient in Bridgmans table, see info for usage";
  Real dpg=-dgp "coefficient in Bridgmans table, see info for usage";
  // Derivatives at constant Temperature
  Real dvT=gamma*v "coefficient in Bridgmans table, see info for usage";
  Real dTv=-dvT "coefficient in Bridgmans table, see info for usage";
  Real dsT=alpha*v "coefficient in Bridgmans table, see info for usage";
  Real dTs=-dsT "coefficient in Bridgmans table, see info for usage";
  Real duT=alpha*T*v - gamma*p*v
    "coefficient in Bridgmans table, see info for usage";
  Real dTu=-duT "coefficient in Bridgmans table, see info for usage";
  Real dhT=-v + alpha*T*v "coefficient in Bridgmans table, see info for usage";
  Real dTh=-dhT "coefficient in Bridgmans table, see info for usage";
  Real dfT=-gamma*p*v "coefficient in Bridgmans table, see info for usage";
  Real dTf=-dfT "coefficient in Bridgmans table, see info for usage";
  Real dgT=-v "coefficient in Bridgmans table, see info for usage";
  Real dTg=-dgT "coefficient in Bridgmans table, see info for usage";
  // Derivatives at constant v
  Real dsv=alpha*alpha*v*v - gamma*v*cp/T
    "coefficient in Bridgmans table, see info for usage";
  Real dvs=-dsv "coefficient in Bridgmans table, see info for usage";
  Real duv=T*alpha*alpha*v*v - gamma*v*cp
    "coefficient in Bridgmans table, see info for usage";
  Real dvu=-duv "coefficient in Bridgmans table, see info for usage";
  Real dhv=T*alpha*alpha*v*v - alpha*v*v - gamma*v*cp
    "coefficient in Bridgmans table, see info for usage";
  Real dvh=-dhv "coefficient in Bridgmans table, see info for usage";
  Real dfv=gamma*v*s "coefficient in Bridgmans table, see info for usage";
  Real dvf=-dfv "coefficient in Bridgmans table, see info for usage";
  Real dgv=gamma*v*s - alpha*v*v
    "coefficient in Bridgmans table, see info for usage";
  Real dvg=-dgv "coefficient in Bridgmans table, see info for usage";
  // Derivatives at constant s
  Real dus=dsv*p "coefficient in Bridgmans table, see info for usage";
  Real dsu=-dus "coefficient in Bridgmans table, see info for usage";
  Real dhs=-v*cp/T "coefficient in Bridgmans table, see info for usage";
  Real dsh=-dhs "coefficient in Bridgmans table, see info for usage";
  Real dfs=alpha*v*s + dus "coefficient in Bridgmans table, see info for usage";
  Real dsf=-dfs "coefficient in Bridgmans table, see info for usage";
  Real dgs=alpha*v*s - v*cp/T
    "coefficient in Bridgmans table, see info for usage";
  Real dsg=-dgs "coefficient in Bridgmans table, see info for usage";
  // Derivatives at constant u
  Real dhu=p*alpha*v*v + gamma*v*cp*p - v*cp - p*T*alpha*alpha*v*v
    "coefficient in Bridgmans table, see info for usage";
  Real duh=-dhu "coefficient in Bridgmans table, see info for usage";
  Real dfu=s*T*alpha*v - gamma*v*cp*p - gamma*v*s*p + p*T*alpha*alpha*v*v
    "coefficient in Bridgmans table, see info for usage";
  Real duf=-dfu "coefficient in Bridgmans table, see info for usage";
  Real dgu=alpha*v*v*p + alpha*v*s*T - v*cp - gamma*v*s*p
    "coefficient in Bridgmans table, see info for usage";
  Real dug=-dgu "coefficient in Bridgmans table, see info for usage";
  //  Derivatives at constant h
  Real dfh=(s - v*alpha*p)*(v - v*alpha*T) - gamma*v*cp*p
    "coefficient in Bridgmans table, see info for usage";
  Real dhf=-dfh "coefficient in Bridgmans table, see info for usage";
  Real dgh=alpha*v*s*T - v*(s + cp)
    "coefficient in Bridgmans table, see info for usage";
  Real dhg=-dgh "coefficient in Bridgmans table, see info for usage";
  // Derivatives at constant g
  Real dfg=gamma*v*s*p - v*s - alpha*v*v*p
    "coefficient in Bridgmans table, see info for usage";
  Real dgf=-dfg "coefficient in Bridgmans table, see info for usage";
  annotation (Documentation(info="<HTML>
<p>
Important: the phase equilibrium conditions are not yet considered.
this means that bridgemans tables do not yet work in the two phase region.
Some derivatives are 0 or infinity anyways.
Idea: don't use the values in Bridgmans table directly, all
derivatives are calculated as the quotient of two entries in the
table. The last letter indicates which variable is held constant in
taking the derivative. The second letters are the two variables
involved in the derivative and the first letter is alwys a d to remind
of differentiation.
</p>

<pre>
Example 1: Get the derivative of specific entropy s w.r.t. Temperature at
constant specific volume (btw identical to constant density)
constant volume  --> last letter v
Temperature      --> second letter T
Specific entropy --> second letter s
--> the needed value is dsv/dTv
Known variables:
Temperature T
pressure p
specific volume v
specific inner energy u
specific enthalpy h
specific entropy s
specific helmholtz energy f
specific gibbs enthalpy g
Not included but useful:
density d
In order to convert derivatives involving density use the following
rules:
at constant density == at constant specific volume
ddx/dyx = -d*d*dvx/dyx with y,x any of T,p,u,h,s,f,g
dyx/ddx = -1/(d*d)dyx/dvx with y,x any of T,p,u,h,s,f,g
Usage example assuming water as the medium:
model BridgmansTablesForWater
extends ThermoFluid.BaseClasses.MediumModels.Water.WaterSteamMedium_ph;
Real derOfsByTAtConstantv \"derivative of sp. entropy by temperature at constant sp. volume\"
ThermoFluid.BaseClasses.MediumModels.Common.ExtraDerivatives dpro;
ThermoFluid.BaseClasses.MediumModels.Common.BridgmansTables bt;
equation
dpro = ThermoFluid.BaseClasses.MediumModels.SteamIF97.extraDerivs_pT(p[1],T[1]);
bt.p = p[1];
bt.T = T[1];
bt.v = 1/pro[1].d;
bt.s = pro[1].s;
bt.cp = pro[1].cp;
bt.alpha = dpro.alpha;
bt.gamma = dpro.gamma;
derOfsByTAtConstantv =  bt.dsv/bt.dTv;
                ...
end BridgmansTablesForWater;
                </pre>

                </HTML>
                "));
end BridgmansTables;
