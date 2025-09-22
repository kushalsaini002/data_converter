class agent_top extends uvm_component;
    `uvm_component_utils(agent_top)

    agent_top agent_toph;
    
    function new(string name="agent_top", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

    endfunction: build_phase

endclass: agent_top