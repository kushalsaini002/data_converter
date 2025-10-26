module tb();
  parameter CLOCK = 5;

  reg rst;
  reg valid_in;
  reg [`INPUT_DATA_WIDTH-1:0] data_in;
  reg clk_in=0, clk_out=0;

  wire valid_out;
  wire [`OUTPUT_DATA_WIDTH-1:0] data_out;

  data_converter dut (
    .rst(rst),
    .valid_in(valid_in),
    .data_in(data_in),
    .clk_in(clk_in),
    .clk_out(clk_out),
    .valid_out(valid_out),
    .data_out(data_out)
  );
 
  initial begin
    forever #(CLOCK) clk_in  = ~clk_in;
  end
  initial begin
  forever #(CLOCK) clk_out = ~clk_out;
  end

  task apply_stimulus(input [`INPUT_DATA_WIDTH-1:0] word);
    begin
      
      @(negedge  clk_in);
      valid_in = 1;
      data_in  = word;
         
      @(negedge  clk_in);
      valid_in = 0;
      data_in = 0;

      repeat (10) @(negedge  clk_in);
      valid_in = 0;
      repeat (8) @(negedge clk_out);
      #(CLOCK); 
    end
  endtask

  initial begin
    clk_in   = 0;
    clk_out  = 0;
    rst      = 1;
    valid_in = 0;
    data_in  = 0;

    #(CLOCK*4);
    rst = 0;

    apply_stimulus(64'hA1B2_C3D4_E5F6_0708);
    apply_stimulus(64'h1122_3344_5566_7788);
    apply_stimulus(64'hDEAD_BEEF_1234_5678);

    #(CLOCK*50);
    $finish;
  end

  // Monitor
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    $monitor("Time=%0t valid_out=%b data_out=%h", $time, valid_out, data_out);
  end

endmodule
