//============================================================
// clk_rst_driver.sv
//
// UVM Driver
//
//============================================================


class clk_rst_driver
extends uvm_driver #(clk_rst_item);



`uvm_component_utils(clk_rst_driver)



virtual clk_rst_if vif;



clk_rst_config cfg;



clock_generator clk_gen[clk_id_e];



reset_controller rst_ctrl;




function new(
string name,
uvm_component parent
);


super.new(
name,
parent
);


endfunction






function void build_phase(
uvm_phase phase
);



super.build_phase(phase);



uvm_config_db#
(
virtual clk_rst_if
)::get
(
this,
"",
"vif",
vif
);



uvm_config_db#
(
clk_rst_config
)::get
(
this,
"",
"cfg",
cfg
);




foreach(clk_gen[i])

begin


clk_gen[i]=new();



clk_gen[i].id=i;


clk_gen[i].cfg=
cfg.clk_cfg[i];


clk_gen[i].vif=vif;



end




rst_ctrl=new();


rst_ctrl.vif=vif;


rst_ctrl.cfg=cfg;



endfunction






//------------------------------------------------------------
// Driver run
//------------------------------------------------------------

task run_phase(
uvm_phase phase
);



fork


start_all_clock();


drive_command();


join



endtask






task start_all_clock();



foreach(clk_gen[i])

begin

clk_gen[i].start();

end



endtask





//------------------------------------------------------------
// Transaction handler
//------------------------------------------------------------


task drive_command();



clk_rst_item req;



forever begin



seq_item_port
.get_next_item(req);



case(req.cmd)



CLK_START:

clk_gen[req.clk_id]
.start();




CLK_STOP:

clk_gen[req.clk_id]
.stop();





SET_FREQ:

begin


clk_gen[req.clk_id]
.cfg.frequency=
req.value;


clk_gen[req.clk_id]
.cfg.period=
1s/req.value;



end






SET_PERIOD:


clk_gen[req.clk_id]
.cfg.period=
req.value;




SET_DUTY:


clk_gen[req.clk_id]
.cfg.duty_cycle=
req.value;






SET_SKEW:


clk_gen[req.clk_id]
.cfg.skew=
req.value;






SET_JITTER:


clk_gen[req.clk_id]
.cfg.jitter=
req.value;






RESET_ASSERT:


rst_ctrl
.assert_reset(req.clk_id);




RESET_RELEASE:


rst_ctrl
.release_reset(req.clk_id);



endcase



seq_item_port.item_done();



end



endtask



endclass
