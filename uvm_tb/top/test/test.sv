class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    env envh;
    env_config env_configh;

    function new(string name="base_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        env_configh=env_config::type_id::create("env_configh");
        if(!uvm_config_db #(virtual conv_interface)::get(this,"", "vif",env_configh.vif))
			`uvm_fatal("TEST CONFIG :","cannot get()interface vif from uvm_config_db. Have you set() it?")

        if(!uvm_config_db #(env_config)::set(this,"*", "env_config",env_configh))
			`uvm_fatal("TEST CONFIG :","cannot set() configuration in test")
        
        envh=env::type_id::create("envh");

    endfunction
endclass

class first_test extends base_test;
    
    function new(string name="first_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase();
        phase.raise_objection();
            //create a sequence item handle
            //start the sequence on the sequencer
        phase.drop_objection();
    endtask
endclass