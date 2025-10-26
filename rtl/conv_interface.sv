interface conv_interface(input bit clk_in,input bit clk_out);

  	logic rst;
    logic valid_in;
    logic [63:0]data_in;
    logic valid_out;
  logic [7:0]data_out;
    
   // bit clk_in,clk_out;

    //assign clk_in = clk_in;
    //assign clk_out = clk_out;

    clocking drv_cb@(posedge clk_in);
        default input #1 output #0;
      	output rst;
        output valid_in;
        output data_in;
    endclocking

    clocking mon_cb@(posedge clk_out);
        default input #0 output #0;
      	input rst;
      	input valid_in;
      	input data_in;
        input valid_out;
        input data_out;
    endclocking

    modport DRV_MP(clocking drv_cb);
    modport MON_MP(clocking mon_cb);
endinterface //conv_interface
