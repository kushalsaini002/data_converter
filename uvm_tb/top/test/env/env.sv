class env extends uvm_env;
  `uvm_component_utils(env)
  
  agent_top agent_toph[];
  scoreboard scoreboardh[];
  env_config env_configh;
  
  function new(string name="env",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //getting env config
    if(!uvm_config_db#(env_config)::get(this, "", "ENV_CONFIG", env_configh))
        `uvm_info("ENV","unable to get ENV_CONFIG",UVM_LOW)

    agent_toph=new[NO_OF_DUTS];

    foreach(agent_toph[i])begin
        //setting different agent config for each agent_top
        uvm_config_db#(agent_config)::set(this,$sformatf("agent_top[%0d]*",i),"AGENT_CONFIG",env_configh.agent_configh[i]);
        //creating agent_top
        agent_toph[i]=agent_top::type_id::create($sformatf("AGENT_TOP[i]",i),this);
    end

    scoreboardh=new[NO_OF_DUTS];
    foreach(scoreboardh[i])
        scoreboardh[i]=scoreboard::type_id::create($sformatf("SCOREBOARD[i]",i),this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    foreach(agent_toph[i])begin
         agent_toph[i].ip_agenth.ip_monh.ip_mon_port.connect(scoreboardh[i].ip_sb_fifo.analysis_export);
         agent_toph[i].op_agenth.op_monh.op_mon_port.connect(scoreboardh[i].op_sb_fifo.analysis_export);
    end
  endfunction
  
endclass