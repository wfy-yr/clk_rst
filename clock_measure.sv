//============================================================
// clock_measure.sv
//
// Clock measurement engine
//
//============================================================


class clock_measure extends uvm_object;


`uvm_object_utils(clock_measure)



//------------------------------------------------------------
// timestamp
//------------------------------------------------------------

time last_rise;

time current_rise;


time last_fall;



//------------------------------------------------------------
// measurement result
//------------------------------------------------------------

time period;


time high_time;


time low_time;



real frequency;


real duty_cycle;



//------------------------------------------------------------
// jitter
//------------------------------------------------------------

time min_period;


time max_period;


time jitter;




int edge_count;




function new(
string name="clock_measure"
);


super.new(name);



period=0;


frequency=0;


duty_cycle=0;


edge_count=0;


min_period='1;


max_period=0;



endfunction





//------------------------------------------------------------
// Rising edge measurement
//------------------------------------------------------------

function void update_rise
(
time t
);



current_rise=t;



if(last_rise!=0)

begin



period =
current_rise-last_rise;



frequency =
1.0e9/period;



if(period < min_period)

min_period=period;



if(period > max_period)

max_period=period;



end



last_rise=current_rise;


edge_count++;



endfunction






//------------------------------------------------------------
// Falling edge measurement
//------------------------------------------------------------


function void update_fall
(
time t
);



last_fall=t;



high_time =
last_fall-last_rise;



if(period!=0)

begin



low_time =
period-high_time;



duty_cycle =
high_time*100.0/period;



end



endfunction






//------------------------------------------------------------
// Calculate jitter
//------------------------------------------------------------


function void calculate_jitter();


jitter=
max_period-min_period;


endfunction





//------------------------------------------------------------
// Print
//------------------------------------------------------------

function void print();


$display(

"CLK MEASURE: PERIOD=%0t FREQ=%0fMHz DUTY=%0f%% JITTER=%0t",

period,

frequency,

duty_cycle,

jitter

);



endfunction


endclass
