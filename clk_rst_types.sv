//============================================================
// clk_rst_types.sv
//
// Common typedef definition
//
//============================================================


typedef enum int {


    CPU_CLK = 0,

    AXI_CLK = 1,

    APB_CLK = 2,

    DDR_CLK = 3


} clk_id_e;



//============================================================
// Clock generation mode
//============================================================

typedef enum int {


    GEN_BY_FREQ,

    GEN_BY_PERIOD


} clk_mode_e;



//============================================================
// Clock command
//============================================================

typedef enum int {


    CLK_START,

    CLK_STOP,


    SET_FREQ,

    SET_PERIOD,


    SET_DUTY,


    SET_PHASE,


    SET_SKEW,


    SET_JITTER,


    SET_SDF_LATENCY,


    INSERT_GLITCH,



    RESET_ASSERT,


    RESET_RELEASE



} clk_cmd_e;



//============================================================
// Reset mode
//============================================================

typedef enum int {


    ASYNC_RESET,


    SYNC_RESET


} reset_mode_e;



//============================================================
// Checker result
//============================================================

typedef enum int {


    CHECK_PASS,


    CHECK_FAIL


} check_result_e;



//============================================================
// Timing violation type
//============================================================

typedef enum int {


    SETUP_VIOLATION,


    HOLD_VIOLATION,


    RECOVERY_VIOLATION,


    REMOVAL_VIOLATION



} violation_type_e;
