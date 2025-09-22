class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)

    virtual dut_if vif;

    uvm_analysis_port #(transaction) analysis_port;

    function new(string name="monitor", uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //if(!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif)) begin
        //    `uvm_fatal("NO VIF", "Virtual interface must be set for: " + get_full_name() + ".vif")
    endfunction // build_phase()


    task run_phase(uvm_phase phase);
        sample();
    endtask // run_phase()

    task sample();

    endtask
endclass: monitor