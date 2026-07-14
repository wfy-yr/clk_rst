//============================================================
// reset_controller.sv
//
// Reset Controller
//
//============================================================


class reset_controller extends uvm_object;


`uvm_object_utils(reset_controller)



virtual clk_rst_if vif;



clk_rst_config cfg;



function new(
string name="reset_controller"
);

super.new(name);


endfunction





//------------------------------------------------------------
// Assert Reset
//------------------------------------------------------------


task assert_reset
(
clk_id_e id
);



case(id)



CPU_CLK:

vif.cpu_rst_n=0;


AXI_CLK:

vif.axi_rst_n=0;


APB_CLK:

vif.apb_rst_n=0;


DDR_CLK:

vif.ddr_rst_n=0;



endcase



`uvm_info(
"RESET",

$sformatf(
"Assert reset %0d",
id),

UVM_LOW)



endtask





//------------------------------------------------------------
// Release Reset
//------------------------------------------------------------


task release_reset
(
clk_id_e id
);



if(cfg.reset_mode==SYNC_RESET)

begin



case(id)



CPU_CLK:

@(posedge vif.cpu_clk);


AXI_CLK:

@(posedge vif.axi_clk);


APB_CLK:

@(posedge vif.apb_clk);


DDR_CLK:

@(posedge vif.ddr_clk);



endcase



end



case(id)



CPU_CLK:

vif.cpu_rst_n=1;


AXI_CLK:

vif.axi_rst_n=1;


APB_CLK:

vif.apb_rst_n=1;


DDR_CLK:

vif.ddr_rst_n=1;



endcase



`uvm_info(
"RESET",

$sformatf(
"Release reset %0d",
id),

UVM_LOW)



endtask






//------------------------------------------------------------
// Reset pulse
//------------------------------------------------------------

task reset_pulse
(
clk_id_e id
);



assert_reset(id);


#cfg.reset_width;


release_reset(id);



endtask



endclass
