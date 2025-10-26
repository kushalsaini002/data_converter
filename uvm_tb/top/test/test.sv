class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    env envh;
    env_config env_configh;

    function new(string name="base_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      configure_db();
        envh=env::type_id::create("envh",this);
    endfunction

    function void configure_db();
        env_configh=env_config::type_id::create("env_configh");
        env_configh.agent_configh=new[NO_OF_DUTS];

        foreach(env_configh.agent_configh[i])begin
            if(!uvm_config_db#(virtual conv_interface)::get(this,"",$sformatf("vif%0d",i),env_configh.agent_configh[i].vif))
                `uvm_fatal("TEST","unable to get physical vif",UVM_LOW)
        end

        uvm_config_db#(env_config)::set(this,"","ENV_CONFIG",env_configh);
    endfunction
endclass

class first_test extends base_test;
    `uvm_component_utils(first_test)
  
  	base_sequence seqh;
  
    function new(string name="first_test",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
      seqh=base_sequence::type_id::create("seqh");
    endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this,"raise");
    seqh.start(envh.agent_toph.ip_agenth.ip_seqrh);
    #100;
    phase.drop_objection(this,"drop");
    endtask
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
endclass