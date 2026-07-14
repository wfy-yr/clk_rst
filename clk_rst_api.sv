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

//============================================================
// Reset API
//============================================================


class reset_handle;



clk_rst_sequencer seq;




function new(
clk_rst_sequencer seq
);


this.seq=seq;


endfunction





task assert
(
clk_id_e id
);



clk_rst_item req;


req=new();



req.cmd=
RESET_ASSERT;



req.clk_id=id;



seq.start_item(req);


seq.finish_item(req);



endtask





task release
(
clk_id_e id
);



clk_rst_item req;


req=new();



req.cmd=
RESET_RELEASE;



req.clk_id=id;



seq.start_item(req);


seq.finish_item(req);



endtask


endclass

//============================================================
// clk_rst_api
//============================================================


class clk_rst_api;



clk_handle cpu_clk;


clk_handle axi_clk;


clk_handle apb_clk;


clk_handle ddr_clk;



reset_handle reset;




clk_rst_sequencer seq;




function new(
clk_rst_sequencer seq
);



this.seq=seq;



cpu_clk=
new(CPU_CLK,seq);



axi_clk=
new(AXI_CLK,seq);



apb_clk=
new(APB_CLK,seq);



ddr_clk=
new(DDR_CLK,seq);




reset=
new(seq);



endfunction



endclass
