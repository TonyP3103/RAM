module datapath (
	input logic [8:0] DIN,
	input logic rst,clk,run, 
	output logic Done,
	output logic [4:0] state,
	output logic [8:0] R0,	R1,	R2,	R3,	R4,	R5,	R6,	R7,	BUS, G_sum, A, G,IR,ADDR,DOUT,
	output logic R0in,		R1in,		R2in,		R3in,		R4in,		R5in,		R6in,		R7in,	IRin,	Address_in,	Dout_in,	W_D,W,	incr_pc, Ain,	AddSub,	Gin, DINout, Gout,
	output logic  R0out,	R1out,	R2out,	R3out,	R4out,	R5out,	R6out,	R7out,	R7out1,	R7out2);
	

	FSM FSM1 (
	.clk(clk),
	.run(run), 
	.rst(rst),
	.DIN(DIN),
	.G(G),  
	.state(state),
	.Gin(Gin),
	.AddSub(AddSub), 
	.Done(Done),	
	.Address_in(Address_in),	
	.Dout_in(Dout_in),	
	.W_D(W_D),	
	.incr_pc(incr_pc),	
	.IRin(IRin), 
	.Ain(Ain),
	.R0in(R0in),
	.R1in(R1in), 
	.R2in(R2in), 	
	.R3in(R3in), 		
	.R4in(R4in), 		
	.R5in(R5in), 	
	.R6in(R6in), 		
	.R7in(R7in), 
	.R0out(R0out), 
	.R1out(R1out), 	
	.R2out(R2out), 	
	.R3out(R3out), 		
	.R4out(R4out), 		
	.R5out(R5out), 	
	.R6out(R6out), 		
	.R7out(R7out), 
	.R7out1(R7out1),
	.R7out2(R7out2),
	.DINout(DINout),	
	.Gout(Gout), 
	 .IR(IR)
	 );
	
	


d_ff R0_ff (.d(BUS),.q(R0),.clk(clk),.EN(R0in),.rst(rst));

d_ff R1_ff (.d(BUS),.q(R1),.clk(clk),.EN(R1in),.rst(rst));

d_ff R2_ff (.d(BUS),.q(R2),.clk(clk),.EN(R2in),.rst(rst));

d_ff R3_ff (.d(BUS),.q(R3),.clk(clk),.EN(R3in),.rst(rst));

d_ff R4_ff (.d(BUS),.q(R4),.clk(clk),.EN(R4in),.rst(rst));

d_ff R5_ff (.d(BUS),.q(R5),.clk(clk),.EN(R5in),.rst(rst));

d_ff R6_ff (.d(BUS),.q(R6),.clk(clk),.EN(R6in),.rst(rst));
	
d_ff A_ff (.d(BUS),.q(A),.EN(Ain),.clk(clk),.rst(rst));

counterR7 counterR7_1 (.clk(clk),.rst(rst),.incr_pc(incr_pc),.R7in(R7in),.BUS(BUS),.R7(R7));

bit8adder bit8adder1 (.a(A),.b(BUS),.cin(AddSub),.out(G_sum));

d_ff G_ff (.d(G_sum),.q(G),.EN(Gin),.clk(clk),.rst(rst));

d_ff addr (.d(BUS),.q(ADDR),.clk(clk),.EN(Address_in),.rst(rst));

d_ff dout (.d(BUS),.q(DOUT),.clk(clk),.EN(Dout_in),.rst(rst));

d_ff1bit w_ff (.d(W_D),.q(W),.clk(clk),.rst(rst),.EN(1'b1));


mux1 mux_1 (
				.clk(clk),
				.R0(R0),
				.R1(R1),
				.R2(R2),
				.R3(R3),
				.R4(R4),
				.R5(R5),
				.R6(R6),
				.R7(R7),
				.DIN(DIN),
				.G(G),
				.R0out(R0out),
				.R1out(R1out),
				.R2out(R2out),
				.R3out(R3out),
				.R4out(R4out),
				.R5out(R5out),
				.R6out(R6out),
				.R7out(R7out),
				.DINout(DINout),
				.Gout(Gout),
				.BUS(BUS));
endmodule 