//============================================================
// clock_generator.sv
//
// Multi clock generator
//
//============================================================


class clock_generator extends uvm_object;


`uvm_object_utils(clock_generator)



//------------------------------------------------------------
// Interface
//------------------------------------------------------------

virtual clk_rst_if vif;



//------------------------------------------------------------
// Configuration
//------------------------------------------------------------

clk_domain_cfg cfg;



clk_id_e id;



bit running;



function new(
string name="clock_generator"
);

super.new(name);


running=0;


endfunction



//------------------------------------------------------------
// Start clock
//------------------------------------------------------------

task start();


running=1;


fork

    clock_process();

join_none



endtask





//------------------------------------------------------------
// Stop clock
//------------------------------------------------------------

task stop();


running=0;


endtask





//------------------------------------------------------------
// Clock process
//------------------------------------------------------------

task clock_process();



time high_time;


time low_time;



forever begin



if(!running)

begin

    #1ns;

    continue;

end




if(!cfg.enable)

begin

    drive_clock(0);

    #1ns;

    continue;

end




//----------------------------------------------------
// calculate duty
//----------------------------------------------------


high_time =
cfg.period *
cfg.duty_cycle /
100.0;



low_time =
cfg.period-high_time;




//----------------------------------------------------
// phase
//----------------------------------------------------

#(cfg.phase);



//----------------------------------------------------
// skew
//----------------------------------------------------

#(cfg.skew);




//----------------------------------------------------
// rising edge
//----------------------------------------------------

drive_clock(1);



#(high_time);



//----------------------------------------------------
// falling edge
//----------------------------------------------------

drive_clock(0);



#(low_time);



end



endtask







//------------------------------------------------------------
// Drive different clocks
//------------------------------------------------------------

task drive_clock(
bit value
);



case(id)



CPU_CLK:

begin

    vif.cpu_clk=value;

end



AXI_CLK:

begin

    vif.axi_clk=value;

end



APB_CLK:

begin

    vif.apb_clk=value;

end



DDR_CLK:

begin

    vif.ddr_clk=value;

end



endcase



endtask



endclass
