echo "Compilation starts"
# define
iverilog -I ../core -y ../core -o sim.out $1
echo "Generate waveforms"
vvp -n sim.out
echo "View waveforms"
echo "---------Simulation is Final!--------"
# gtkwave sim_out.vcd
