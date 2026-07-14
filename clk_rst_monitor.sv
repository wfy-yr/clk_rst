//============================================================
// clk_rst_monitor.sv
//
// Clock Reset Monitor
//
//============================================================


class clk_rst_monitor
extends uvm_monitor;



`uvm_component_utils(clk_rst_monitor)



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


monitor_reset();



join



endtask






task monitor_cpu();


forever begin


@(posedge vif.cpu_clk);



`uvm_info(
"CLK_MON",

"CPU clock edge",

UVM_LOW)



end



endtask






task monitor_axi();


forever begin


@(posedge vif.axi_clk);



`uvm_info(
"CLK_MON",

"AXI clock edge",

UVM_LOW)



end



endtask






task monitor_apb();


forever begin


@(posedge vif.apb_clk);



`uvm_info(
"CLK_MON",

"APB clock edge",

UVM_LOW)



end



endtask






task monitor_ddr();


forever begin


@(posedge vif.ddr_clk);



`uvm_info(
"CLK_MON",

"DDR clock edge",

UVM_LOW)



end



endtask






task monitor_reset();


forever begin


@(vif.cpu_rst_n or
  vif.axi_rst_n or
  vif.apb_rst_n or
  vif.ddr_rst_n);



`uvm_info(
"RESET_MON",

"Reset changed",

UVM_LOW)



end



endtask



endclass
