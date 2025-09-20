`define INPUT_DATA_WIDTH 64
`define OUTPUT_DATA_WIDTH 8

module data_converter (
    input wire valid_in,
    input wire [`INPUT_DATA_WIDTH - 1:0] data_in,
    input wire clk_in,
    input wire clk_out,

    output reg valid_out,
    output reg [`OUTPUT_DATA_WIDTH - 1:0] data_out
);

   //memory to hold the converted data
    reg [`INPUT_DATA_WIDTH -1 :0] mem_in;
    reg [`OUTPUT_DATA_WIDTH -1 :0] mem_out [7:0];

    always@(posedge clk_in) begin
        if(valid_in)
            mem_in <= data_in; 
    end

    always@(posedge clk_out) begin
        // Conversion logic from 64-bit to 8-bit data
        if(valid_out)
        for(int i = 0; i < 8; i++) begin
            int lsb= i*8;
            int msb= lsb+7;
            mem_out[i] <= mem_in[msb:lsb];
            data_out <= mem_out[i];
        end
            
    end

endmodule   