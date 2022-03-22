/********* FSM Module **********/
    module FSM (
                   input                           Activate         ,
                   input                           Up_Max           ,
                   input                           Dn_Max           ,
                   input                           clk              ,
                   input                           rst              ,
                   output           reg            UP_M             ,
                   output           reg            DN_M             
    );

    //states 
    localparam [1:0] IDLE               =          2'b00 ;
    localparam [1:0] Mv_Up              =          2'b01 ;
    localparam [1:0] Mv_Dn              =          2'b10 ;

    reg [1:0] current_state        ;            
    reg [1:0] next_state           ;

    always @(posedge clk,negedge rst ) begin
        if ((rst==1'b0)) begin
            current_state <= IDLE       ;
        end else begin
            current_state <= next_state ;
        end   
    end    
    always @(Activate or Up_Max or Dn_Max) begin
        case (current_state)
           IDLE :   begin
               if (Activate==1'b0) begin
                   next_state          = IDLE     ;
                   UP_M                = 1'b0     ;
                   DN_M                = 1'b0     ;
               end else if (Dn_Max==1'b1) begin
                   next_state          = Mv_Up    ;
                   UP_M                = 1'b1     ;
                   DN_M                = 1'b0     ;
               end else if (Up_Max==1'b1) begin
                   next_state          = Mv_Dn    ;
                   DN_M                = 1'b1     ;
                   UP_M                = 1'b0     ;
               end else begin
                   next_state          = IDLE     ;
                   UP_M                = 1'b0     ;
                   DN_M                = 1'b0     ;

               end 
               end
               
                   
               
           Mv_Dn :   begin
               if ((Dn_Max==1'b0) && (Activate==1'b1)) begin
                   next_state          = Mv_Dn    ;
                   DN_M                = 1'b1     ;
                   UP_M                = 1'b0     ;
               end 
               else begin
                   next_state          = IDLE     ;
                   UP_M                = 1'b0     ;
                   DN_M                = 1'b0     ;
                   
               end
               end  
           Mv_Up :   begin
               if ((Up_Max==1'b0) && (Activate==1'b1)) begin
                   next_state          = Mv_Up    ;
                   UP_M                = 1'b1     ;
                   DN_M                = 1'b0     ;
               end else begin
                   next_state          = IDLE     ;
                   UP_M                = 1'b0     ;
                   DN_M                = 1'b0     ;
               end
               end     
            
            default: begin
                next_state             = IDLE     ;
                UP_M                   = 1'b0     ;
                DN_M                   = 1'b0     ;
            end
        endcase
    end        
    endmodule