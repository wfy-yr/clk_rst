//============================================================
// clk_rst_summary.sv
//============================================================


class clk_rst_summary;



static clock_measure measure[clk_id_e];



static function void print();



$display("");

$display(
"================================================"
);


$display(
"CLK_RST_AGENT SUMMARY"
);



$display(
"================================================"
);



foreach(measure[i])

begin



if(measure[i]!=null)



begin



$display(

"CLK=%0d PERIOD=%0t FREQ=%0fMHz DUTY=%0f%% JITTER=%0t",

i,

measure[i].period,

measure[i].frequency,

measure[i].duty_cycle,

measure[i].jitter



);



end



end



$display(
"================================================"
);



endfunction



endclass
