class ip_agent extends uvm_agent;
    `uvm_component_utils(ip_agent)
  
  ip_driver ip_drvh;
  ip_monitor ip_monh;
  ip_sequencer ip_seqrh;

  agent_config ag_configh;
  
    function new(string name="ip_agent",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(agent_config)::get(this, "", "AGENT_CONFIG", ag_configh))
            `uvm_info("IP_AGENT","unable to get AGENT_CONFIG",UVM_LOW)

        ip_monh=ip_monitor::type_id::create("ip_monh",this);

        if(ag_configh.is_active==UVM_ACTIVE)begin
            ip_drvh=ip_driver::type_id::create("ip_drvh",this);
            ip_seqrh=ip_sequencer::type_id::create("ip_seqrh",this);
        end
      
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(ag_configh.is_active==UVM_ACTIVE)begin
            ip_drvh.seq_item_port.connect(ip_seqrh.seq_item_export);
        end
      
    endfunction
endclass