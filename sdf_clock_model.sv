//============================================================
// sdf_clock_model.sv
//
// Gate-level SDF clock latency model
//
//============================================================


class sdf_clock_model extends uvm_object;


`uvm_object_utils(sdf_clock_model)



//------------------------------------------------------------
// clock
//------------------------------------------------------------

clk_id_e id;



//------------------------------------------------------------
// SDF delay
//------------------------------------------------------------

time clock_latency;



time clock_uncertainty;



bit enable;



virtual clk_rst_if vif;



function new(
string name="sdf_clock_model"
);

super.new(name);



enable=0;


clock_latency=0;


clock_uncertainty=0;



endfunction





//------------------------------------------------------------
// Configure
//------------------------------------------------------------


function void set_latency
(
time latency
);


clock_latency=latency;


enable=1;



endfunction





function void set_uncertainty
(
time value
);



clock_uncertainty=value;



endfunction





//------------------------------------------------------------
// Apply delay
//------------------------------------------------------------


task apply();



if(!enable)

return;



case(id)



CPU_CLK:

apply_cpu();



AXI_CLK:

apply_axi();



APB_CLK:

apply_apb();



DDR_CLK:

apply_ddr();



endcase



endtask






//------------------------------------------------------------
// CPU
//------------------------------------------------------------


task apply_cpu();



forever begin


@(posedge vif.cpu_clk);



#clock_latency;



end



endtask






task apply_axi();



forever begin


@(posedge vif.axi_clk);



#clock_latency;



end



endtask






task apply_apb();



forever begin


@(posedge vif.apb_clk);



#clock_latency;



end



endtask






task apply_ddr();



forever begin


@(posedge vif.ddr_clk);



#clock_latency;



end



endtask



endclass
