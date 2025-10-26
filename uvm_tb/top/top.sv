`include "package.sv"
`include "conv_interface.sv"
`include "uvm_macros.svh"
//import uvm_pkg::*;
import pkg::*;

module conv_top;
  
	import uvm_pkg::*;
  
	bit clock_in,clock_out;  
		//assigning clock to interface
   		conv_interface   in0(clock_in,clock_out);
      conv_interface   in1(clock_in,clock_out);
      conv_interface   in2(clock_in,clock_out);
		//connecting interface to DUT
    	data_converter  DUV0(.rst(in0.rst),
                            .valid_in(in0.valid_in),
                            .data_in(in0.data_in),
                            .valid_out(in0.valid_out),
                            .data_out(in0.data_out),
                            .clk_in(clock_in),
                            .clk_out(clock_out));
                          
      data_converter  DUV1(.rst(in1.rst),
                            .valid_in(in1.valid_in),
                            .data_in(in1.data_in),
                            .valid_out(in1.valid_out),
                            .data_out(in1.data_out),
                            .clk_in(clock_in),
                            .clk_out(clock_out));

      data_converter  DUV2(.rst(in2.rst),
                            .valid_in(in2.valid_in),
                            .data_in(in2.data_in),
                            .valid_out(in2.valid_out),
                            .data_out(in2.data_out),
                            .clk_in(clock_in),
                            .clk_out(clock_out));
  
	// Generate clock signal		
  	always 
      #10 clock_in=(~clock_in);

    always 
      #10 clock_out=(~clock_out);

   	// In initial block
   	initial 
		begin
      $dumpfile("conv_top.vcd");
      $dumpvars(0,conv_top);
      
			uvm_config_db #(virtual conv_interface)::set(null,"*","vif",in0);
      uvm_config_db #(virtual conv_interface)::set(null,"*","vif",in1);
      uvm_config_db #(virtual conv_interface)::set(null,"*","vif",in2);
			//Call run_test
      run_test("first_test");
		end
  
  	initial begin
      fork
        begin
          in0.rst<=1'b0;
          in0.valid_in<=1'b0;
          in0.data_in<=0;
      @(posedge clock_in);
          in0.rst<=1'b1;
      @(posedge clock_in);
          in0.rst<=1'b0;
        end

        begin
          in1.rst<=1'b0;
          in1.valid_in<=1'b0;
          in1.data_in<=0;
      @(posedge clock_in);
          in1.rst<=1'b1;
      @(posedge clock_in);
          in1.rst<=1'b0;
        end

        begin
          in2.rst<=1'b0;
          in2.valid_in<=1'b0;
          in2.data_in<=0;
      @(posedge clock_in);
          in2.rst<=1'b1;
      @(posedge clock_in);
          in2.rst<=1'b0;
        end

      join_none
    end

endmodule