//============================================================
// timing_violation_analyzer.sv
//
// Timing violation analysis
//
//============================================================


class timing_violation_analyzer
extends uvm_component;



`uvm_component_utils(
timing_violation_analyzer
)



//------------------------------------------------------------
// violation info
//------------------------------------------------------------


violation_type_e type;



time clock_latency;


time clock_skew;


time clock_jitter;


time timing_margin;




function new(
string name,
uvm_component parent
);


super.new(name,parent);



endfunction






//------------------------------------------------------------
// Analyze
//------------------------------------------------------------


function void analyze
(
violation_type_e v
);



type=v;



case(v)



SETUP_VIOLATION:


begin


`uvm_error(

"TIMING",

"Setup violation detected"

)


end






HOLD_VIOLATION:


begin


`uvm_error(

"TIMING",

"Hold violation detected"

)


end






RECOVERY_VIOLATION:


begin


`uvm_error(

"RESET",

"Recovery violation detected"

)


end






REMOVAL_VIOLATION:


begin


`uvm_error(

"RESET",

"Removal violation detected"

)


end



endcase



print_report();



endfunction







//------------------------------------------------------------
// Report
//------------------------------------------------------------


function void print_report();



$display("");

$display(
"===================================="
);


$display(
" Timing Violation Analysis"
);



$display(
" Clock latency : %0t",
clock_latency
);



$display(
" Clock skew    : %0t",
clock_skew
);



$display(
" Clock jitter  : %0t",
clock_jitter
);



$display(
" Margin        : %0t",
timing_margin
);



$display(
"===================================="
);



endfunction



endclass
