
package pkg;

parameter NO_OF_DUTS=10;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

    `include "transaction.sv"
    `include "sequence.sv"
    //`include "agent_config.sv"
	`include "ip_sequencer.sv"
	`include "ip_driver.sv"
    `include "ip_monitor.sv"
    `include "ip_agent.sv"
	`include "op_monitor.sv"
    `include "op_agent.sv"
    `include "agent_top.sv"
	`include "scoreboard.sv"
    `include "env.sv"
    //`include "env_config.sv"
    `include "test.sv"

endpackage