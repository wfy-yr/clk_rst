//============================================================
// clk_rst_item.sv
//
// UVM sequence item
//
//============================================================


class clk_rst_item extends uvm_sequence_item;



`uvm_object_utils_begin(clk_rst_item)



`uvm_field_enum(
clk_cmd_e,
cmd,
UVM_ALL_ON)



`uvm_field_enum(
clk_id_e,
clk_id,
UVM_ALL_ON)



`uvm_field_real(
value,
UVM_ALL_ON)



`uvm_field_int(
int_value,
UVM_ALL_ON)



`uvm_object_utils_end




//------------------------------------------------------------
// Command
//------------------------------------------------------------

rand clk_cmd_e cmd;



//------------------------------------------------------------
// Clock ID
//------------------------------------------------------------

rand clk_id_e clk_id;



//------------------------------------------------------------
// Parameter value
//------------------------------------------------------------

rand real value;



rand int int_value;





function new(
string name="clk_rst_item"
);


super.new(name);


endfunction



endclass
