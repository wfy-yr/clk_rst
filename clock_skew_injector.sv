//============================================================
// clock_skew_injector.sv
//
// Clock tree skew injection
//
//============================================================


class clock_skew_injector
extends uvm_object;



`uvm_object_utils(clock_skew_injector)



clk_id_e id;


time skew;




virtual clk_rst_if vif;




function new(
string name="clock_skew_injector"
);


super.new(name);


endfunction





//------------------------------------------------------------
// apply
//------------------------------------------------------------


task apply();



case(id)



CPU_CLK:

begin

#skew;

end



AXI_CLK:

begin

#skew;

end



APB_CLK:

begin

#skew;

end



DDR_CLK:

begin

#skew;

end



endcase



endtask



endclass
