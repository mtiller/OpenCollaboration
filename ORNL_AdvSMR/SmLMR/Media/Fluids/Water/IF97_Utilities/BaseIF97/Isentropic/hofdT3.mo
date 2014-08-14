within ORNL_AdvSMR.SmLMR.Media.Fluids.Water.IF97_Utilities.BaseIF97.Isentropic;
function hofdT3 "function for isentropic specific enthalpy in region 3"

  extends Modelica.Icons.Function;
  input SI.Density d "density";
  input SI.Temperature T "temperature (K)";
  output SI.SpecificEnthalpy h "specific enthalpy";
protected
  Real delta;
  Real tau "dimensionless temperature";
  Real[13] o "vector of auxiliary variables";
  Real ftau "derivative of  dimensionless Helmholtz energy w.r.t. tau";
  Real fdelta "derivative of  dimensionless Helmholtz energy w.r.t. delta";
algorithm
  tau := data.TCRIT/T;
  delta := d/data.DCRIT;
  o[1] := tau*tau;
  o[2] := o[1]*o[1];
  o[3] := o[2]*o[2];
  o[4] := o[3]*tau;
  o[5] := o[1]*o[2]*o[3]*tau;
  o[6] := o[2]*o[3];
  o[7] := o[1]*o[3];
  o[8] := o[3]*o[3];
  o[9] := o[1]*o[2]*o[8];
  o[10] := o[1]*o[2]*o[8]*tau;
  o[11] := o[3]*o[8];
  o[12] := o[3]*o[8]*tau;
  o[13] := o[1]*o[3]*o[8];

  ftau := 20.944396974307 + tau*(-15.3735415757432 + o[2]*tau*(
    18.3301634515678 + o[1]*tau*(-28.08078114862 + o[1]*(
    14.4640436358204 - 0.194503669468755*o[1]*o[3]*tau)))) +
    delta*((-2.5308630955428 + o[2]*(-6.9146446840086 + (
    13.2781565976477 - 10.9153200808732*o[1])*o[4]))*tau +
    delta*(tau*(-1.70429417648412 + o[2]*(29.3833689251262 + (-21.3518320798755
     + (0.867251811341388 + 3.26518619032008*o[2])*o[5])*tau))
     + delta*((2.779959913892 + o[1]*(-8.075966009428 + o[6]*(-0.131436219478341
     - 12.37496929108*o[7])))*tau + delta*((-0.88952870857478
     + o[1]*(3.62288282878932 + 18.3358370228714*o[9]))*tau +
    delta*(0.10770512626332 + o[1]*(-0.98740869776862 -
    13.2264761307011*o[10]) + delta*((0.188521503330184 +
    4.27343239646986*o[11])*tau + delta*(-0.027006744482696*tau
     + delta*(-0.385692979164272*o[12] + delta*(delta*(-0.00016557679795037
     - 0.00116802137560719*delta*o[12]) + (0.00115845907256168
     + 0.0840031522296486*o[11])*tau)))))))));

  fdelta := (1.0658070028513 + delta*(o[1]*(-1.2654315477714 +
    o[2]*(-1.1524407806681 + (0.88521043984318 -
    0.64207765181607*o[1])*o[4])) + delta*(0.76986920373342 + o[
    1]*(-1.70429417648412 + o[2]*(9.7944563083754 + (-6.100523451393
     + (0.078841073758308 + 0.25116816848616*o[2])*o[5])*tau))
     + delta*(-0.8399798909613 + o[1]*(4.169939870838 + o[1]*(-6.056974507071
     + o[6]*(-0.0246442911521889 - 1.42788107204769*o[7]))) +
    delta*(0.175936297894 + o[1]*(-1.77905741714956 + o[1]*(
    3.62288282878932 + 2.82089800351868*o[9])) + delta*(delta*(
    -0.133052405238576 + o[1]*(0.565564509990552 +
    0.98617670687766*o[11]) + delta*(-0.094523605689436*o[1] +
    delta*(-0.118674762819776*o[13] + delta*(o[1]*(
    0.00521306582652756 + 0.0290780142333399*o[11]) + delta*(
    0.00080964802996215 - 0.000494162889679965*delta*o[13] -
    0.0016557679795037*tau))))) + (0.5385256313166 + o[1]*(-1.6456811629477
     - 2.5435531020579*o[10]))*tau))))))/delta;

  h := data.RH2O*T*(tau*ftau + delta*fdelta);
end hofdT3;
