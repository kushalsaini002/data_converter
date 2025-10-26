class ip_monitor extends uvm_monitor;
    `uvm_component_utils(ip_monitor)

    virtual conv_interface vif;

  uvm_analysis_port #(transaction) ip_mon_port;

    function new(string name="ip_monitor", uvm_component parent);
        super.new(name, parent);
        ip_mon_port = new("analysis_port", this);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      if(!uvm_config_db#(agent_config)::get(this, "", "AGENT_CONFIG", ag_configh))
        `uvm_fatal("ip_monitor CONFIG:", "unable to get AGENT_CONFIG in ip_monitor, check have you setted it?")
    endfunction // build_phase()

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
      vif=ag_configh.vif;
    endfunction // connect_phase()

    task run_phase(uvm_phase phase);
        forever begin
          @(vif.mon_cb);
          	if(vif.valid_in)
            	sample();
        end
        
    endtask // run_phase()

    task sample();
        transaction mon_txn;
      	mon_txn=transaction::type_id::create("mon_txn");
      	  mon_txn.rst = vif.mon_cb.rst;
          mon_txn.valid_in = vif.mon_cb.valid_in;
          mon_txn.data_in = vif.mon_cb.data_in;
      
      //mon_txn.do_print();
      `uvm_info("ip_monitor:",$sformatf("transaction to DUT to sb \n %s", mon_txn.sprint()),UVM_LOW)

      ip_mon_port.write(mon_txn);
    endtask
endclass: ip_monitor