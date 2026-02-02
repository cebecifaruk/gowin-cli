# GOWIN IDE CLI Project Template

This is a simple template for creating GOWIN FPGA projects using the GOWIN IDE CLI and make. This example is configured
for Sipeed Tang Primer 20K board.

- You can generate bitstream files with `make` command.
- You can upload your code to the FPGA board's flash memory using the `make flash` command.
- You can upload your code to the FPGA's SRAM using the `make run` command.

If you have another board you can easily modify it for other boards by changing;

- The constraints file which is located in `pins.cst`.
- The project settings which are located in `project.tcl`.
- The Makefile settings.

Have fun!
