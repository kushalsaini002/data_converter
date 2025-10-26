class ip_sequencer extends uvm_sequencer #(transaction);

  `uvm_component_utils(ip_sequencer)

  function new(string name = "ip_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction : new

endclass : ip_sequencer