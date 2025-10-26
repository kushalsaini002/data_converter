class transaction extends uvm_sequence_item;

    logic valid_in = 1'b1;
    rand logic data_in[63:0];
    logic valid_out=1'b1;
    logic data_out[7:0];

  `uvm_object_utils(transaction)

  function new(string name = "transaction");
    super.new(name);
  endfunction : new

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("data_in", data_in, $bits(data_in));
    printer.print_field_int("data_out", data_out, $bits(data_out));
  endfunction : do_print

  function string convert2string();
    return $sformatf("data_in = %0h, data_out = %0h", data_in, data_out);
  endfunction : convert2string

endclass : transaction