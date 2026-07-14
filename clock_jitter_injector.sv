//============================================================
// clock_jitter_injector.sv
//
// PLL jitter model
//
//============================================================


class clock_jitter_injector
extends uvm_object;



`uvm_object_utils(clock_jitter_injector)



// maximum jitter

time jitter_range;




function new(
string name="clock_jitter_injector"
);


super.new(name);


jitter_range=0;



endfunction






//------------------------------------------------------------
// random jitter
//------------------------------------------------------------


function time get_jitter();



int value;



value =
$urandom_range
(
-jitter_range,
jitter_range
);



return value;



endfunction






//------------------------------------------------------------
// inject
//------------------------------------------------------------


task inject_delay();


#(get_jitter());



endtask



endclass
