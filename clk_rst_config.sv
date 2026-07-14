//============================================================
// clk_rst_config.sv
//
// Configuration object
//
//============================================================


class clk_domain_cfg extends uvm_object;


    `uvm_object_utils(clk_domain_cfg)



    //--------------------------------------------------------
    // Name
    //--------------------------------------------------------

    string name;



    //--------------------------------------------------------
    // Clock basic parameter
    //--------------------------------------------------------

    real frequency;


    time period;


    real duty_cycle;



    //--------------------------------------------------------
    // Clock variation
    //--------------------------------------------------------

    time phase;


    time skew;


    time jitter;



    //--------------------------------------------------------
    // SDF
    //--------------------------------------------------------

    bit enable_sdf;


    time sdf_latency;



    //--------------------------------------------------------
    // Enable
    //--------------------------------------------------------

    bit enable;



    //--------------------------------------------------------
    // Checker expectation
    //--------------------------------------------------------

    real expect_frequency;


    time expect_period;


    real expect_duty;



    real freq_tolerance;


    time period_tolerance;


    real duty_tolerance;




    function new(
        string name="clk_domain_cfg"
    );


        super.new(name);


        this.name=name;



        frequency=100;


        period=10ns;


        duty_cycle=50;



        phase=0;


        skew=0;


        jitter=0;



        enable=1;



        enable_sdf=0;


        sdf_latency=0;



        expect_frequency=100;


        expect_period=10ns;


        expect_duty=50;



        freq_tolerance=1;


        period_tolerance=100ps;


        duty_tolerance=5;



    endfunction


endclass





//============================================================
// Global configuration
//============================================================


class clk_rst_config extends uvm_object;



`uvm_object_utils(clk_rst_config)



clk_domain_cfg clk_cfg[clk_id_e];



reset_mode_e reset_mode;



time reset_width;


time reset_delay;



function new(
string name="clk_rst_config"
);



super.new(name);



foreach(clk_cfg[i])

begin


    clk_cfg[i]=new();


end



clk_cfg[CPU_CLK].name="cpu_clk";


clk_cfg[AXI_CLK].name="axi_clk";


clk_cfg[APB_CLK].name="apb_clk";


clk_cfg[DDR_CLK].name="ddr_clk";



reset_mode=ASYNC_RESET;


reset_width=100ns;


reset_delay=100ns;



endfunction


endclass
