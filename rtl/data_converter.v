`define INPUT_DATA_WIDTH 64
`define OUTPUT_DATA_WIDTH 8

module data_converter (
    input  wire rst,
    input  wire valid_in,
    input  wire [`INPUT_DATA_WIDTH-1:0] data_in,
    input  wire clk_in,
    input  wire clk_out,

    output reg  valid_out,
    output reg  [`OUTPUT_DATA_WIDTH-1:0] data_out
);

    reg [`INPUT_DATA_WIDTH-1:0] mem_in;
    reg [3:0] count_in;    
    reg [2:0] count_out;   
    reg       start_output; 

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            mem_in       <= 0;
            count_in     <= 0;
            start_output <= 0;
        end
      	else begin
            if (valid_in)
                mem_in <= data_in;

            if (valid_in || count_in != 0) begin
                count_in <= count_in + 1;
              if (count_in == 1) begin
                    start_output <= 1; 
                    count_in <= 0;     
                end
            end
        end
    end

    always @(posedge clk_out or posedge rst) begin
        if (rst) begin
            count_out <= 0;
            valid_out <= 0;
        end 
      	else begin
            if (start_output) begin
                valid_out <= 1;
                count_out <= 0;
                start_output <= 0;
            end 
          	else if (valid_out) begin
                if (count_out == 7) begin
                    valid_out <= 0;
                    count_out <= 0;
                end 
              	else begin
                    count_out <= count_out + 1;
                end
            end
        end
    end

    always @(*) begin
        if (valid_out)
            data_out = mem_in[count_out*8 +: 8]; 
        else
            data_out = 0;
    end

endmodule
