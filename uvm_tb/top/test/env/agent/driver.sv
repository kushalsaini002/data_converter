class driver extends uvm_driver #(transaction);

    virtual conv_interface.DRV_MP vif;

    function new(string name="driver", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction // build_phase()

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction // connect_phase()

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
    endtask // run_phase()

    task send_to_dut(transaction drv_txn);
        forever begin
            `uvm_info("DRIVER",$sformatf("printing from driver \n %s", drv_txn.sprint()),UVM_LOW)

        @(vif.drv_cb);
            vif.valid_in<=drv_txn.valid_in;
            vif.data_in<=drv_txn.data_in;
        repeat(10)
            @(vif.drv_cb)
        end
    endtask // send_to_dut()
endclass // driver extends uvm_driver #(transaction)