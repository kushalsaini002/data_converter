class driver extends uvm_driver #(transaction);
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
        super.run_phase(phase);
        fork
            send_to_dut();
        join_none
    endtask // run_phase()

    task send_to_dut();
        transaction tr;
        forever begin
            seq_item_port.get_next_item(tr);
            // Send the transaction to the DUT
            // (Assuming there's a method in the DUT interface to send data)
            // dut_if.send_data(tr.data);
            `uvm_info("DRIVER", $sformatf("Driving data: %0h", tr.data), UVM_LOW)
            seq_item_port.item_done();
        end
    endtask // send_to_dut()
endclass // driver extends uvm_driver #(transaction)