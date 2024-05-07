module FSM (
	input logic clk, run, rst,
	input logic [8:0] DIN,G,  
	output logic [4:0] state,
	output logic Gin, 	AddSub, Done,	Address_in,	Dout_in,	W_D,	incr_pc,	IRin, Ain,
	output logic R0in,	R1in, 	R2in, 	R3in, 		R4in, 		R5in, 	R6in, 		R7in, 
	output logic R0out, R1out, 	R2out, 	R3out, 		R4out, 		R5out, 	R6out, 		R7out, R7out1,R7out2,DINout,	Gout, 
	output logic [8:0] IR
);



d_ff IR_ff (.d(DIN),.q(IR),.clk(clk),.EN(IRin),.rst(rst));

logic [7:0] outX,outY;
logic RXin,RXout,RYout;


assign R0in = (outX[0] & RXin);
assign R1in = (outX[1] & RXin);
assign R2in = (outX[2] & RXin);
assign R3in = (outX[3] & RXin); 
assign R4in = (outX[4] & RXin);
assign R5in = (outX[5] & RXin);
assign R6in = (outX[6] & RXin);
assign R7in = (outX[7] & RXin);

assign R0out 	= (outY[0] & RYout) 	| 	(outX[0] & RXout);
assign R1out 	= (outY[1] & RYout) 	| 	(outX[1] & RXout);
assign R2out 	= (outY[2] & RYout) 	| 	(outX[2] & RXout);
assign R3out 	= (outY[3] & RYout) 	| 	(outX[3] & RXout);
assign R4out 	= (outY[4] & RYout) 	| 	(outX[4] & RXout);
assign R5out	= (outY[5] & RYout) 	| 	(outX[5] & RXout);
assign R6out 	= (outY[6] & RYout) 	| 	(outX[6] & RXout);
assign R7out1 	= (outY[7] & RYout) 	| 	(outX[7] & RXout);
assign R7out 	= R7out1 ^ R7out2;

decoder decoderRX (.sel(IR[5:3]),.out(outX));
decoder decoderRY (.sel(IR[2:0]),.out(outY));


typedef enum bit [4:0] {		reset 		=5'b00000,
								ldaddress 	=5'b00001,
								PCcount		=5'b00010,
								fetch 		=5'b00011,
								fetch1			=5'b00100,
								mv1 		=5'b00101,
								mvi0		=5'b00110,
								mvi1		=5'b00111,
								mvi2		=5'b01000,
								mvi3		=5'b01001,
								add1		=5'b01010,
								add2		=5'b01011,
								add3		=5'b01100,
								sub1		=5'b01101,
								sub2		=5'b01110,
								sub3 		=5'b01111,
								ld1		=5'b10000,	
								ld2		=5'b10001,	
								ld3		=5'b10010,	
								st1		=5'b10011,		
								st2		=5'b10100,	
								st3		=5'b10101,
								mvnz		=5'b10110
								} state_t;
state_t state_reg, state_next;

always_ff @(posedge clk or negedge rst) begin
	if (!rst)
		state_reg <= reset;
	else if ( run == 1'b1)
		state_reg <= state_next;
end

always_comb begin
	state_next = state_reg;
	
	case (state_reg)
	reset: begin 
					RXin 		= 1'b0; 
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
						if (!rst) 
							state_next = reset;
						else 
							state_next = ldaddress;
					end

	ldaddress: begin 
					RXin 		= 1'b0; 
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done		= 1'b0;
					Address_in 	= 1'b1;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b1;
						
						state_next = PCcount;
					end

	PCcount: begin 
					RXin 		= 1'b0; 
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b1;
					R7out2		= 1'b0;
						
						state_next = fetch;
					end
					

	fetch: begin 
					RXin 		= 1'b0; 
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b1; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
			
						state_next = fetch1;
	end 
				

	fetch1: begin 
					RXin 		= 1'b0; 
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
						if   (IR[8:6] == 3'b000)
							state_next = mv1;
						else if  (IR[8:6] == 3'b001)
							state_next = mvi0;
						else if   (IR[8:6] == 3'b010)
							state_next = add1;
						else if  (IR[8:6] == 3'b011)
							state_next = sub1;
						else if   (IR[8:6] == 3'b100)
							state_next = ld1;
						else if  (IR[8:6] == 3'b101)
							state_next = st1;
						else if  (IR[8:6] == 3'b110)
							state_next = mvnz;
			end 	
			
	mv1: begin 
					RXin 		= 1'b1; 
					RXout 		= 1'b0;
					RYout	 	= 1'b1;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain		 	= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b1;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next 	= ldaddress;
				end

	mvi0: begin 
					RXin 		= 1'b0; 
					RXout		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b1;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b1;
					state_next = mvi1;
				end
				

	mvi1: begin 
					RXin 		= 1'b0; 
					RXout		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next = mvi2;
				end
	
	mvi2: begin 
					RXin 		= 1'b0; 
					RXout 		= 1'b0;
					RYout	 	= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next 	= mvi3;
				
				end
				
	mvi3: begin 
					RXin 		= 1'b1; 
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b1; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b1;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b1;
					R7out2		= 1'b0;
					state_next = ldaddress;
				end
				
					
			
				
			add1: begin 
					RXin 		= 1'b0;
					RXout 		= 1'b1;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b1;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next = add2;
				end
						
				
		add2: begin 
					RXin 		= 1'b0;
					RXout 		= 1'b0;
					RYout 		= 1'b1;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b1; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next = add3;
				end				
		add3: begin 
					RXin 		= 1'b1;
					RXout 		= 1'b0;
					RYout	 	= 1'b0;
					Gout 		= 1'b1;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b1;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next = ldaddress;
				end
			
	
	sub1: begin 
					RXin 		= 1'b0;
					RXout 		= 1'b1;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b1;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next = sub2;
				end
				
	sub2: begin 
					RXin 		= 1'b0;
					RXout 		= 1'b0;
					RYout 		= 1'b1;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b1; 
					AddSub		= 1'b1; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next = sub3;
				end
				
	sub3: begin 
					RXin 		= 1'b1;
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b1;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b1;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;
					state_next = ldaddress;
				end
				

		ld1: begin
					RXin 		= 1'b0;
					RXout 		= 1'b0;
					RYout 		= 1'b1;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b1;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;					
					state_next 	= ld2;
				end 
		
		ld2: begin
					RXin 		= 1'b0;
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;					
					state_next 	= ld3;
				end 
				
		ld3: begin
					RXin 		= 1'b1;
					RXout 		= 1'b0;
					RYout 		= 1'b0;
					Gout 		= 1'b0;
					DINout		= 1'b1; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b1;
					Address_in 	= 1'b0;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;					
					state_next 	= ldaddress;
				end 
				

		st1: begin
					RXout = 1'b1; 
					RYout = 1'b0;
					Gout = 1'b0;
					DINout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0;  
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					Address_in = 1'b0;
					Dout_in = 1'b1;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					state_next = st2;
				end 

		st2: begin
				RXout = 1'b0; 
					RYout = 1'b1;
					Gout = 1'b0;
					DINout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0;  
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					Address_in = 1'b1;
					Dout_in = 1'b0;
					W_D = 1'b0;
					incr_pc = 1'b0;
					R7out2 = 1'b0;
					state_next = st3;
				end 		
				
				
		
		st3: begin
		RXout = 1'b0; 
					RYout = 1'b0;
					Gout = 1'b0;
					DINout = 1'b0; 
					IRin = 1'b0; 
					Ain = 1'b0;
					RXin = 1'b0; 
					Gin = 1'b0; 
					AddSub = 1'b0; 
					Done = 1'b0;
					Address_in = 1'b0;
					Dout_in = 1'b0;
					W_D = 1'b1;
					incr_pc = 1'b0;
					R7out2 = 1'b0;				
					state_next 	= ldaddress;
				end 

		mvnz: begin 
					RXin 		= 1'b0;
					RXout 		= 1'b0;
					RYout 		= 1'b1;
					Gout 		= 1'b0;
					DINout		= 1'b0; 
					IRin 		= 1'b0; 
					Ain 		= 1'b0;  
					Gin 		= 1'b0; 
					AddSub		= 1'b0; 
					Done 		= 1'b0;
					Address_in 	= 1'b1;
					Dout_in 	= 1'b0;
					W_D 		= 1'b0;
					incr_pc 	= 1'b0;
					R7out2		= 1'b0;		
					if ( G != 0)
						state_next = mv1;
					else if ( G == 0)
						state_next = ldaddress;
			end
endcase 			
end

assign state = state_reg;

endmodule

