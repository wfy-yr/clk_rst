//============================================================
// clock_tree_checker.sv
//
// Clock tree skew checker
//
//============================================================


class clock_tree_checker extends uvm_component;



`uvm_component_utils(clock_tree_checker)



clock_measure measure[clk_id_e];




function new(
string name,
uvm_component parent
);


super.new(name,parent);



foreach(measure[i])

measure[i]=new();



endfunction





//------------------------------------------------------------
// Compare clock
//------------------------------------------------------------


function void compare_clock
(

clk_id_e clk_a,

clk_id_e clk_b

);



time skew;



skew=
abs(

measure[clk_a].last_rise -

measure[clk_b].last_rise

);



if(skew > 100ps)



`uvm_error(

"CLOCK_SKEW",

$sformatf(

"Clock skew %0t between %0d and %0d",

skew,

clk_a,

clk_b

)



)



else



`uvm_info(

"CLOCK_SKEW",

$sformatf(

"Clock skew OK %0t",

skew

),

UVM_LOW)



endfunction



endclass
