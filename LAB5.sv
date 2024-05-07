module LAB5 (
    input logic CLOCK_50,KEY[3:0],SW[9:0],
	output logic Done,
	output logic [8:0] R0,	R1,	R2,	R3,	R4,	R5,	R6,	R7,	BUS, G_sum, A, G,IR,
	output logic [8:0] ADDRESS,DOUT,DIN,
	output logic [8:0] LEDR,
	output logic [4:0] state,
	output logic R0in,		R1in,		R2in,		R3in,		R4in,		R5in,		R6in,		R7in,	IRin,	Address_in,	Dout_in,	W_D,	W,	incr_pc, Ain,	AddSub,	Gin, DINout, Gout,
	output logic R0out,	R1out,	R2out,	R3out,	R4out,	R5out,	R6out,	R7out,	R7out1,	R7out2,
	output logic A7A8_1,A7A8_2,wrenenable,ledsenable);



assign A7A8_1 = ~(ADDRESS[7] | ADDRESS[8]); 
assign A7A8_2 = ~(~ADDRESS[7] | ADDRESS[8]);
assign wrenenable = A7A8_1 & W;
assign ledsenable = W & A7A8_2;


datapath datapath1 (
    .DIN(DIN),
	.rst(KEY[0]),
    .clk(CLOCK_50),
    .run(SW[9]), 
	.Done(Done),
	.state(state),
	.R0(R0),	
    .R1(R1),
    .R2(R2),
    .R3(R3),	
    .R4(R4),
    .R5(R5),
	.R6(R6),
    .R7(R7),
    .BUS(BUS),
    .G_sum(G_sum),
    .A(A), 
    .G(G),
    .IR(IR),
    .ADDR(ADDRESS),
    .DOUT(DOUT),
    .W(W),
	 .R0in(R0in),
	 .R1in(R1in),
	 .R2in(R2in),
	 .R3in(R3in),
	 .R4in(R4in),
	 .R5in(R5in),
	 .R6in(R6in),
	 .R7in(R7in),
	 .IRin(IRin),
	 .Address_in(Address_in),
	 .Dout_in(Dout_in),
	 .W_D(W_D),
	 .incr_pc(incr_pc),
	 .Ain(Ain),
	 .AddSub(AddSub),
	 .Gin(Gin),
	 .DINout(DINout),
	 .Gout(Gout),
	 .R0out(R0out),
	 .R1out(R1out),
	 .R2out(R2out),
	 .R3out(R3out),
	 .R4out(R4out),
	 .R5out(R5out),
	 .R6out(R6out),
	 .R7out(R7out),
	 .R7out1(R7out1),
	 .R7out2(R7out2)
	 );

d_ff final_1 (.d(DOUT),.rst(KEY[0]),.clk(CLOCK_50),.EN(ledsenable),.q(LEDR));

RAM RAM1 (.address(ADDRESS[6:0]),
	.clock(CLOCK_50),
	.data(DOUT),
	.wren(wrenenable),
	.q(DIN));

    endmodule 