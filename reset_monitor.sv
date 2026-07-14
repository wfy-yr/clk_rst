//============================================================
// reset_monitor.sv
//
// Reset monitor
//
//============================================================


class reset_monitor extends uvm_monitor;


`uvm_component_utils(reset_monitor)



virtual clk_rst_if vif;




function new(
string name,
uvm_component parent
);


super.new(name,parent);


endfunction






task run_phase(
uvm_phase phase
);



fork


monitor_cpu();


monitor_axi();


monitor_apb();


monitor_ddr();



join



endtask





task monitor_cpu();



forever begin



@(vif.cpu_rst_n);



if(vif.cpu_rst_n)



`uvm_info(

"RESET_MON",

"CPU RESET RELEASE",

UVM_LOW)



else



`uvm_info(

"RESET_MON",

"CPU RESET ASSERT",

UVM_LOW)



end



endtask





task monitor_axi();



forever begin



@(vif.axi_rst_n);



if(vif.axi_rst_n)



`uvm_info(

"RESET_MON",

"AXI RESET RELEASE",

UVM_LOW)



else



`uvm_info(

"RESET_MON",

"AXI RESET ASSERT",

UVM_LOW)



end



endtask






task monitor_apb();



forever begin



@(vif.apb_rst_n);



if(vif.apb_rst_n)



`uvm_info(

"RESET_MON",

"APB RESET RELEASE",

UVM_LOW)



else



`uvm_info(

"RESET_MON",

"APB RESET ASSERT",

UVM_LOW)



end



endtask





task monitor_ddr();



forever begin



@(vif.ddr_rst_n);



if(vif.ddr_rst_n)



`uvm_info(

"RESET_MON",

"DDR RESET RELEASE",

UVM_LOW)



else



`uvm_info(

"RESET_MON",

"DDR RESET ASSERT",

UVM_LOW)



end



endtask



endclass
