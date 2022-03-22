    /*************test bench ***********/
    `timescale 1ns/1ns
    module FSM_tb (
    );
        reg              Activate_tb              ;
        reg              Up_Max_tb                ;
        reg              Dn_Max_tb                ;
        reg              clk_tb                   ;
        reg              rst_tb                   ;
        wire             UP_M_tb                  ;
        wire             DN_M_tb                  ;

        parameter CLOCK_PERIOD = 20               ;
        parameter HALF_PERIOD  = CLOCK_PERIOD / 2 ;
        
        wire [1:0] output_signals                  ;
        assign  output_signals = {DN_M_tb,UP_M_tb} ;
        initial begin
        $dumpfile("FSM.vcd");
        $dumpvars;
        
        clk_tb         = 1'b0                                 ;
        rst_tb         = 1'b0                                 ;
        Activate_tb    = 1'b0                                 ;
        #5
        /******test case 1 ********/
        #3 
        Activate_tb = 1'b1 ;
        Dn_Max_tb   = 1'b0 ;
        Up_Max_tb   = 1'b1 ;
        rst_tb      = 1'b1 ;
        #CLOCK_PERIOD
        //input_signals = 3'b110 ;
        if (output_signals == 2'b10) begin
            $display("test 1 passed");
        end else begin
            $display("test 1 failed");
        end
        /******test case 2 ********/
        
        Activate_tb = 1'b1 ;
        Dn_Max_tb   = 1'b1 ;
        Up_Max_tb   = 1'b0 ;
        rst_tb      = 1'b1 ;
        #CLOCK_PERIOD
        if (output_signals == 2'b00) begin
            $display("test 2 passed");
        end else begin
            $display("test 2 failed");
        end
        /******test case 3 ********/
        Activate_tb = 1'b1 ;
        Dn_Max_tb   = 1'b0 ;
        Up_Max_tb   = 1'b1 ;
        rst_tb      = 1'b1 ;
        #CLOCK_PERIOD
        if (output_signals == 2'b10) begin
            $display("test 3 passed");
        end else begin
            $display("test 3 failed");
        end
        /******test case 4 ********/
        Activate_tb = 1'b0 ;
        Dn_Max_tb   = 1'b0 ;
        Up_Max_tb   = 1'b1 ;
        rst_tb      = 1'b1 ; 
        #CLOCK_PERIOD
        if (output_signals == 2'b00) begin
            $display("test 4 passed");
        end else begin
            $display("test 4 failed");
        end
        /******test case 5 ********/
        Activate_tb = 1'b1 ;
        Dn_Max_tb   = 1'b1 ;
        Up_Max_tb   = 1'b0 ;
        rst_tb      = 1'b1 ; 
        #CLOCK_PERIOD
        if (output_signals == 2'b01) begin
            $display("test 5 passed");
        end else begin
            $display("test 5 failed");
        end
        #1000
        $finish;
        end


    //clock generator
    always #HALF_PERIOD clk_tb = ~ clk_tb     ;

        FSM DUT (
            .Activate(Activate_tb),
            .Up_Max(Up_Max_tb),
            .Dn_Max(Dn_Max_tb),
            .clk(clk_tb),
            .rst(rst_tb),
            .UP_M(UP_M_tb),
            .DN_M(DN_M_tb)
        );
    endmodule