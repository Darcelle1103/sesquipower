sesquipower



An R package to size the compensation of reactive power in a single-phase

domestic electrical installation.



From the voltage and current of an appliance, the package works out how much

useful and wasted power it draws, estimates the energy and its cost, and tells

you which capacitors to install to reduce the wasted power.



 Why compensate reactive power?



Appliances with motors or transformers (fridges, air conditioners, pumps) draw

two kinds of power:



- active power, which does the actual work (heat, light, motion);

- reactive power, which does no work but increases the current flowing in

&#x20; the wires.



A higher current means more heat and more losses in the cables. Capacitors

installed alongside the appliance supply this reactive power locally, so the

wires carry less current.



```



\## The functions



&#x20;`VectorGeneration()` : Prepares the voltage and the current from their values and phase shift. 

&#x20;`PowerCalculation()` : Computes the active, reactive and apparent power. 

&#x20;`CalculateEnergyCost()` : Computes the energy used over a period and its cost. 

&#x20;`OptimizeReactivePower()` : Computes the capacity of each capacitor needed. 



Use `?OptimizeReactivePower` (or the name of any other function) to see its

full help page.



\## Units



\- Voltage in volts, current in amperes, angles in radians.

\- Power in watts (active) and var (reactive).

\- Duration in hours.



\## Good to know



\- The package is designed for \*\*single-phase\*\* installations and \*\*identical

&#x20; capacitors\*\* connected in parallel.

\- The cost calculation uses a \*\*fixed tiered tariff\*\* written in the code. Adapt

&#x20; it to your own electricity tariff.

\- You must always tell `OptimizeReactivePower()` how many capacitors to use.



\## License



MIT

