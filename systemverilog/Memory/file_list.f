-timescale=1ns/1ns
// Macro define
//+define+INC_COUNTER

//+define+WR_RD_TEST
//+RANDOM_TEST

 
// Source file
./rtl/memory.sv

// Testbench
//tb/*.sv
./tb/transaction.sv
./tb/environment.sv
./tb/driver.sv
./tb/generator.sv
./tb/interface.sv
./tb/monitor.sv
//./tb/random_test.sv
./tb/scoreboard.sv
./tb/top.sv
//./tb/wr_rd_test.sv
//./tb/default_test.sv


