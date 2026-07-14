//============================================================
// reset_checker.sv
//
// Reset timing checker
//
//============================================================


class reset_checker extends uvm_monitor;


`uvm_component_utils(reset_checker)



virtual clk_rst_if vif;



//------------------------------------------------------------
// configuration
//------------------------------------------------------------


time min_recovery_time;


time min_removal_time;


time min_reset_width;





//------------------------------------------------------------
// timestamp
//------------------------------------------------------------


time reset_release_time;


time reset_assert_time;





function new(
string name,
uvm_component parent
);


super.new(name,parent);



min_recovery_time = 100ps;


min_removal_time  = 100ps;


min_reset_width   = 10ns;



endfunction






//------------------------------------------------------------
// Run
//------------------------------------------------------------


task run_phase(
uvm_phase phase
);



fork


check_cpu_reset();


check_axi_reset();


check_apb_reset();


check_ddr_reset();



join



endtask





//------------------------------------------------------------
// CPU reset
//------------------------------------------------------------


task check_cpu_reset();



forever begin



@(negedge vif.cpu_rst_n);



reset_assert_time=$time;




@(posedge vif.cpu_rst_n);



reset_release_time=$time;



check_width();



@(posedge vif.cpu_clk);



check_recovery();



end



endtask






//------------------------------------------------------------
// AXI
//------------------------------------------------------------


task check_axi_reset();



forever begin



@(negedge vif.axi_rst_n);



reset_assert_time=$time;



@(posedge vif.axi_rst_n);



reset_release_time=$time;



check_width();



@(posedge vif.axi_clk);



check_recovery();



end



endtask





//------------------------------------------------------------
// APB
//------------------------------------------------------------


task check_apb_reset();



forever begin



@(negedge vif.apb_rst_n);



reset_assert_time=$time;



@(posedge vif.apb_rst_n);



reset_release_time=$time;



check_width();



@(posedge vif.apb_clk);



check_recovery();



end



endtask






//------------------------------------------------------------
// DDR
//------------------------------------------------------------


task check_ddr_reset();



forever begin



@(negedge vif.ddr_rst_n);



reset_assert_time=$time;



@(posedge vif.ddr_rst_n);



reset_release_time=$time;



check_width();



@(posedge vif.ddr_clk);



check_recovery();



end



endtask







//------------------------------------------------------------
// Recovery Check
//------------------------------------------------------------


task check_recovery();



time delta;



delta=
$time-reset_release_time;



if(delta < min_recovery_time)



begin



`uvm_error(

"RESET_RECOVERY",

$sformatf(

"Recovery violation delta=%0t",

delta

)



)



end



endtask







//------------------------------------------------------------
// Reset width
//------------------------------------------------------------


task check_width();



time width;



width=
reset_release_time -
reset_assert_time;



if(width < min_reset_width)



begin



`uvm_error(

"RESET_WIDTH",

$sformatf(

"Reset pulse too short %0t",

width

)



)



end



endtask



endclass
