//============================================================
// glitch_injector.sv
//
// Clock glitch injection
//
//============================================================


class glitch_injector
extends uvm_object;



`uvm_object_utils(glitch_injector)



virtual clk_rst_if vif;



time width;




function new(
string name="glitch_injector"
);


super.new(name);



width=10ps;



endfunction






//------------------------------------------------------------
// CPU glitch
//------------------------------------------------------------


task cpu_glitch();



force vif.cpu_clk=1;



#width;



force vif.cpu_clk=0;



#1ps;



release vif.cpu_clk;



endtask






//------------------------------------------------------------
// AXI glitch
//------------------------------------------------------------


task axi_glitch();



force vif.axi_clk=1;



#width;



force vif.axi_clk=0;



release vif.axi_clk;



endtask




endclass
