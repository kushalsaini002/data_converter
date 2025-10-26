class agent_top extends uvm_component;
    `uvm_component_utils(agent_top)

    ip_agent ip_agenth;
  	op_agent op_agenth;
  
    function new(string name="agent_top", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      ip_agenth=ip_agent::type_id::create("ip_agenth",this);
      op_agenth=op_agent::type_id::create("op_agenth",this);
    endfunction: build_phase

endclass: agent_top