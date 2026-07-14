//============================================================
// clk_rst_api.sv
//
// VIP API
//
//============================================================



class clk_handle;



clk_id_e id;


clk_rst_sequencer seq;



function new
(
clk_id_e id,

clk_rst_sequencer seq
);



this.id=id;


this.seq=seq;



endfunction






//------------------------------------------------------------
// frequency
//------------------------------------------------------------


task gen_clk_by_freq
(
real freq
);



clk_rst_item req;



req=new();



req.cmd=SET_FREQ;


req.clk_id=id;


req.value=freq;



seq.start_item(req);


seq.finish_item(req);



endtask






//------------------------------------------------------------
// period
//------------------------------------------------------------


task gen_clk_by_period
(
time period
);



clk_rst_item req;


req=new();



req.cmd=SET_PERIOD;


req.clk_id=id;


req.value=period;



seq.start_item(req);


seq.finish_item(req);



endtask






//------------------------------------------------------------
// jitter
//------------------------------------------------------------


task set_jitter
(
time value
);



clk_rst_item req;


req=new();



req.cmd=SET_JITTER;


req.clk_id=id;


req.value=value;



seq.start_item(req);


seq.finish_item(req);



endtask






//------------------------------------------------------------
// skew
//------------------------------------------------------------


task set_skew
(
time value
);



clk_rst_item req;


req=new();



req.cmd=SET_SKEW;


req.clk_id=id;


req.value=value;



seq.start_item(req);


seq.finish_item(req);



endtask



endclass
