interface conv_interface(input bit clk_in,input bit clk_out);

    logic valid_in;
    logic data_in[63:0];
    logic valid_out;
    logic data_out[7:0];
    
    bit clk_in,clk_out;

    assign this.clk_in = clk_in;
    assign this.clk_out = clk_out;

    clocking drv_cb(@posedge clk_in);
        default input #1 output #1;
        output valid_in;
        output data_in;
    endclocking

    clocking mon_cb(@posedge clk_out);
        default input #1 output #1;
        input valid_out;
        input data_out;
    endclocking

    modport DRV_MP(clocking drv_cb);
    modport MON_MP(clocking mon_cb);
endinterface //conv_interface
