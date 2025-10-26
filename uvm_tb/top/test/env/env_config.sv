class env_config extends uvm_object;
    `uvm_object_utils(env_config)

    virtual conv_interface vif;
    agent_config agent_configh[];
endclass