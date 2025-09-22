class transaction extends uvm_sequence_item;

  rand bit [63:0] data_in;
  bit [7:0] data_out;

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