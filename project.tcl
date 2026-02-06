# https://cdn.gowinsemi.com.cn/SUG1220E.pdf

# Create a new project for Sipeed Tang Primer 20K
create_project -name project -dir . -pn GW2A-LV18PG256C8/I7 -device_version C

# Import source files
add_file "../src/main.v"
add_file "../src/ws2812.v"
add_file "../src/clk_div.v"
add_file "../pins.cst"

# Set top module
set_option -top_module main

# Set other parameters
set_option -global_freq default

# Set GPIO options
set_option -use_jtag_as_gpio 0
set_option -use_sspi_as_gpio 1
set_option -use_mspi_as_gpio 0
set_option -use_ready_as_gpio 1
set_option -use_done_as_gpio 1
set_option -use_reconfign_as_gpio 0
