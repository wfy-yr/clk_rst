//============================================================
// clock_checker.sv
//
// Clock checker
//
//============================================================


class clock_checker extends uvm_monitor;


`uvm_component_utils(clock_checker)



virtual clk_rst_if vif;



clk_id_e id;



clk_domain_cfg cfg;



clock_measure measure;



time last_edge;




function new(
string name,
uvm_component parent
);


super.new(name,parent);


measure=new();


endfunction





//------------------------------------------------------------
// build
//------------------------------------------------------------

function void build_phase
(
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



endfunction






//------------------------------------------------------------
// Run
//------------------------------------------------------------


task run_phase
(
uvm_phase phase
);



case(id)



CPU_CLK:

check_cpu();


AXI_CLK:

check_axi();


APB_CLK:

check_apb();


DDR_CLK:

check_ddr();



endcase



endtask





//------------------------------------------------------------
// CPU clock check
//------------------------------------------------------------


task check_cpu();



forever begin



@(posedge vif.cpu_clk);



measure.update_rise($time);



@(negedge vif.cpu_clk);



measure.update_fall($time);



check_measure();



end



endtask






task check_axi();



forever begin


@(posedge vif.axi_clk);


measure.update_rise($time);



@(negedge vif.axi_clk);


measure.update_fall($time);



check_measure();



end



endtask





task check_apb();



forever begin


@(posedge vif.apb_clk);


measure.update_rise($time);



@(negedge vif.apb_clk);


measure.update_fall($time);



check_measure();



end



endtask






task check_ddr();



forever begin


@(posedge vif.ddr_clk);


measure.update_rise($time);



@(negedge vif.ddr_clk);


measure.update_fall($time);



check_measure();



end



endtask






//------------------------------------------------------------
// Main check
//------------------------------------------------------------

task check_measure();



check_period();


check_frequency();


check_duty();


check_jitter();



endtask






//------------------------------------------------------------
// Period
//------------------------------------------------------------

task check_period();



if(
abs(
measure.period -
cfg.expect_period
)
>
cfg.period_tolerance
)



begin



`uvm_error(

"CLK_PERIOD",

$sformatf(

"Clock %s period error EXP=%0t ACT=%0t",

cfg.name,

cfg.expect_period,

measure.period

)



)



end



endtask






//------------------------------------------------------------
// Frequency
//------------------------------------------------------------

task check_frequency();



real error;



error =
(
measure.frequency-
cfg.expect_frequency
)
/
cfg.expect_frequency
*
100;



if(
error >
cfg.freq_tolerance
)



`uvm_error(

"CLK_FREQ",

$sformatf(

"Clock %s frequency error=%0f%%",

cfg.name,

error

)



)



endtask






//------------------------------------------------------------
// Duty
//------------------------------------------------------------


task check_duty();



if(

abs(
measure.duty_cycle-
cfg.expect_duty
)
>
cfg.duty_tolerance

)



`uvm_error(

"CLK_DUTY",

"Clock duty violation"

)



endtask






//------------------------------------------------------------
// Jitter
//------------------------------------------------------------


task check_jitter();



measure.calculate_jitter();



if(
measure.jitter >
cfg.jitter
)



`uvm_error(

"CLK_JITTER",

"Clock jitter violation"

)



endtask



endclass
