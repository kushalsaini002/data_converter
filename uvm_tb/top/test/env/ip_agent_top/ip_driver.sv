class ip_driver extends uvm_driver #(transaction);
  `uvm_component_utils(ip_driver)
    //virtual conv_interface.DRV_MP vif;
  	virtual conv_interface vif;
  
  	agent_config ag_configh;

    function new(string name="ip_driver", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      if(!uvm_config_db#(agent_config)::get(this, "", "AGENT_CONFIG", ag_configh))
        `uvm_info("ip_driver","unable to get AGENT_CONFIG",UVM_LOW)
    endfunction // build_phase()

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
      vif=ag_configh.vif;
    endfunction // connect_phase()

    task run_phase(uvm_phase phase);
      forever begin
        seq_item_port.get_next_item(req);
        send_to_dut(req);
        seq_item_port.item_done();
      end
    endtask // run_phase()

    task send_to_dut(transaction drv_txn);
      repeat(3)
          @(vif.drv_cb);
              vif.drv_cb.valid_in<=1'b1;
              vif.drv_cb.data_in<=req.data_in;
          @(vif.drv_cb);
              vif.drv_cb.valid_in<=1'b0;
              vif.drv_cb.data_in<=0;
        
        `uvm_info("ip_driver",$sformatf("ip_driver:data driven\n %s", req.sprint()),UVM_LOW)
        repeat(10)
          @(vif.drv_cb);
    endtask // send_to_dut()
endclass // ip_driver extends uvm_driver #(transaction)